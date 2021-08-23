class ProfileController < ApplicationController
  before_action :authenticate_user!
  layout "dashboard"

  def index
    @manual_entry = Entry.new
    @startable_entry = Entry.new
    @pagy, @finished_entries = pagy(current_user.entries.finished.order(finished_at: :desc))
    @ongoing = current_user.entries.ongoing.first
  end
end
