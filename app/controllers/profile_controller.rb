class ProfileController < ApplicationController
  before_action :authenticate_user!

  def index
    @manual_entry = Entry.new
    @startable_entry = Entry.new
    @finished_entries = current_user.entries.finished.order(updated_at: :desc)
    @ongoing = current_user.entries.ongoing.first
  end
end
