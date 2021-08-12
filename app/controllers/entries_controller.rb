class EntriesController < ApplicationController
  def create
    @entry = Entry.new(entry_type: entry_params[:entry_type], comment: entry_params[:comment])
    @entry.user_id = current_user.id

    set_start_and_finish

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
    @entry.update(finished_at: Time.now)
    flash[:notice] = "Entry completed!"
    redirect_to profile_path
  end

  private

  def entry_params
    params.require(:entry).permit(:entry_type, :comment, :started_at, :finish_time)
  end

  def set_start_and_finish
    # if the started_at param exists, it means that the entry was added manually
    if entry_params[:started_at]
      @entry.started_at = Time.parse(entry_params[:started_at])
    else
      @entry.started_at = Time.now
    end
    # if the finished_time param exists, it means that the entry was added manually
    # so we append the finish_time to started_at date object and set it as the finished_at date
    if entry_params[:finish_time]
      hour, min = entry_params[:finish_time].split(":")
      @entry.finished_at = Time.parse(entry_params[:started_at]).change({ hour: hour, min: min })
    end
  end
end
