class EntriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_ongoing, only: [:start, :finish]

  def create
    @entry = Entry.new(
      entry_type: entry_params[:entry_type],
      comment: entry_params[:comment],
      user: current_user,
    )

    set_start_and_finish

    if @entry.save
      flash[:notice] = "Entry created!"
      redirect_to profile_path
    else
      flash[:error] = "Entry could not be created."
      redirect_to profile_path
    end
  end

  def start
    if !@ongoing
      @entry = Entry.new(entry_params)
      @entry.user = current_user
      @entry.save
      @entry.start!
      flash[:notice] = "Entry started!"
    else
      flash[:error] = "You already have a running entry!"
    end
    redirect_to profile_path
  end

  def finish
    @ongoing.finish!
    flash[:notice] = "Entry completed!"
    redirect_to profile_path
  end

  def destroy
    @entry = current_user.entries.find(params[:id])
    @entry.destroy
    flash[:notice] = "Entry deleted!"
    redirect_to profile_path
  end

  private

  def entry_params
    params.require(:entry).permit(:entry_type, :comment, :started_at, :finish_time)
  end

  def set_start_and_finish
    @entry.started_at = Time.parse(entry_params[:started_at])
    finish_time = Time.parse(entry_params[:finish_time])

    if finish_time < @entry.started_at
      @entry.finished_at = finish_time + 1.day
    else
      @entry.finished_at = finish_time
    end
  end

  def set_ongoing
    @ongoing ||= current_user.entries.ongoing.first
  end
end
