class Admin::EntriesController < ApplicationController
  include AuthorizeAdminConcern
  layout "dashboard"
  require "csv"

  def index
    @q = Entry.ransack(params[:q])
    @results = @q.result.order(started_at: :desc).includes(:user)

    respond_to do |format|
      format.html { @pagy, @entries = pagy(@results) }
      format.csv do
        response.headers["Content-Type"] = "text/csv"
        response.headers["Content-Disposition"] = "attachment; filename=Report-#{Date.today}.csv"
        render :template => "admin/entries/index.csv.haml"
      end
      format.xlsx do
        response.headers["Content-Disposition"] = "attachment; filename=Report-#{Date.today}.xlsx"
        render :template => "admin/entries/index.xlsx.axlsx"
      end
    end
  end
end
