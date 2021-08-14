module ApplicationHelper
  include Pagy::Frontend

  def format_date(date)
    date.in_time_zone("Istanbul").strftime("%B %e, %Y %H:%M:%S")
  end

  def format_duration(duration)
    seconds_diff = duration

    hours = seconds_diff / 3600
    seconds_diff -= hours * 3600

    minutes = seconds_diff / 60
    seconds_diff -= minutes * 60

    seconds = seconds_diff

    "%02d:%02d:%02d" % [hours, minutes, seconds]
  end

  def get_report_title
    from = params.dig(:q, :from)
    from_date = Date.parse(params[:q][:from]).strftime("%B %d, %Y") if from.present?
    to = params.dig(:q, :to)
    to_date = Date.parse(params[:q][:to]).strftime("%B %d, %Y") if to.present?

    if from_date || to_date
      "Results between <strong>#{from_date || "..."}</strong> - <strong>#{to_date || "..."}</strong>"
    end
  end
end
