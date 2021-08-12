class Admin::ReportsController < ApplicationController
  def index
    @selected_users = params[:user_ids].present? ? User.where(id: params[:user_ids]) : User.all

    respond_to do |format|
      format.html do
        @pagy, @users = pagy(@selected_users)
      end
      format.csv do
        response.headers["Content-Type"] = "text/csv"
        response.headers["Content-Disposition"] = "attachment; filename=Report-#{Date.today}.csv"
        render :template => "admin/reports/index.csv.haml"
      end
    end
  end
end
