class Admin::EntriesController < ApplicationController
  include AuthorizeAdminConcern

  def index
    @entries = Entry.filter(params[:q])
    @entry_types = Entry.all.collect { |e| e.entry_type }.uniq
    @users = User.all
  end
end
