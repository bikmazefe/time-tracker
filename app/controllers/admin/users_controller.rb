class Admin::UsersController < ApplicationController
  include AuthorizeAdminConcern
  before_action :set_time_period
  layout "dashboard"

  def index
    @q = Entry.ransack(params[:q])
    @users = @q.result.group_by_user

    respond_to do |format|
      format.html
      format.csv do
        response.headers["Content-Type"] = "text/csv"
        response.headers["Content-Disposition"] = "attachment; filename=Report-#{Date.today}.csv"
        render :template => "admin/users/index.csv.haml"
      end
      format.xlsx do
        response.headers["Content-Disposition"] = "attachment; filename=Report-#{Date.today}.xlsx"
        render :template => "admin/users/index.xlsx.axlsx"
      end
    end
  end

  private

  def set_time_period
    if params[:time_period] == "this_week"
      params[:q][:started_at_gteq] = Date.today.beginning_of_week
      params[:q][:started_at_lteq] = Date.today.end_of_week
    elsif params[:time_period] == "this_month"
      params[:q][:started_at_gteq] = Date.today.beginning_of_month
      params[:q][:started_at_lteq] = Date.today.end_of_month
    end
  end
end
