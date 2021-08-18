module DateHelpers
  def format_date(date)
    date.in_time_zone("Istanbul").strftime("%B %e, %Y %H:%M:%S")
  end
end
