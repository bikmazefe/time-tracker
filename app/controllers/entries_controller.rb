class EntriesController < ApplicationController
  def create
    @entry = Entry.new(entry_params)
    @entry.user_id = current_user.id
    @entry.started_at = params[:started_at] || DateTime.now

    if @entry.save
      flash[:notice] = "Entry created!"
      redirect_to profile_path
    else
      flash[:error] = "Entry could not be created."
      redirect_to profile_path
    end
  end

  def finish
    @entry = current_user.entries.ongoing.first
    @entry.update(finished_at: DateTime.now)
    flash[:notice] = "Entry completed!"
    redirect_to profile_path
  end

  private

  def entry_params
    params.require(:entry).permit(:entry_type, :comment, :started_at, :finished_at)
  end
end
