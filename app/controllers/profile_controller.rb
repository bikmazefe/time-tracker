class ProfileController < ApplicationController
  before_action :authenticate_user!
  layout "dashboard"

  def index
    @new_manual_entry = Entry.new
    @new_timer_entry = Entry.new
    @pagy, @finished_entries = pagy(current_user.entries.finished.order(started_at: :desc))
    @ongoing = current_user.entries.ongoing.first
  end

  def calendar
    @entries = current_user.entries

    respond_to do |format|
      format.html
      format.json { render json: EntriesRepresenter.new(@entries).as_json }
    end
  end
end
