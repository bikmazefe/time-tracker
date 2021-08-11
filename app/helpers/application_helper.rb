module ApplicationHelper
  def format_date(date)
    date.strftime("%B %e, %Y %H:%M:%S")
  end
end
