# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend

  def date_to_iso(date)
    date.iso8601
  end

  def get_entry_range(entry)
    formatted_time = ->(date) { date.in_time_zone("Istanbul").strftime("%H:%M") }

    "#{formatted_time.call(entry.started_at)} - #{formatted_time.call(entry.finished_at)}"
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

  def get_search_title
    from = params.dig(:q, :from)
    from_date = Date.parse(params[:q][:from]).strftime("%B %d, %Y") if from.present?
    to = params.dig(:q, :to)
    to_date = Date.parse(params[:q][:to]).strftime("%B %d, %Y") if to.present?

    if from_date || to_date
      " | #{from_date || "..."} - #{to_date || "..."}"
    end
  end
end
