class Admin::ReportsController < ApplicationController
  require "csv"
  before_action :set_selected_users

  def index
    respond_to do |format|
      format.html do
        @pagy, @users = pagy(@selected_users)
      end
      format.csv do
        response.headers["Content-Type"] = "text/csv"
        response.headers["Content-Disposition"] = "attachment; filename=Report-#{Date.today}.csv"
        render :template => "admin/reports/index.csv.haml"
      end
      format.xlsx do
        response.headers["Content-Disposition"] = "attachment; filename=Report-#{Date.today}.xlsx"
      end
    end
  end

  private

  def set_selected_users
    user_ids_param = params.dig(:q, :user_ids)
    if user_ids_param.present? && user_ids_param.all? { |item| item.present? }
      @selected_users = User.includes(:entries).where(id: user_ids_param)
    else
      @selected_users = User.includes(:entries).all
    end
  end
end
