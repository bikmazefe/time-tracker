class Admin::EntriesController < ApplicationController
  include AuthorizeAdminConcern
  before_action :set_user_ids

  def index
    @pagy, @entries = pagy(Entry.where(user_id: @user_ids).search(params[:q]))
    @users = User.all
  end

  private

  def set_user_ids
    user_ids_param = params.dig(:q, :user_ids)
    if user_ids_param.present? && user_ids_param.all? { |item| item.present? }
      @user_ids = user_ids_param
    else
      @user_ids = User.without_admins.pluck(:id)
    end
  end
end
