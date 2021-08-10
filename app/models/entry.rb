class Entry < ApplicationRecord
  belongs_to :user

  validates_presence_of :started_at, :finished_at, :entry_type

  scope :by_user, lambda { |ids| where(user_id: ids) }
  scope :at_between, lambda { |start_date, end_date| where(finished_at: start_date.beginning_of_day..end_date.end_of_day) }

  def duration
    seconds_diff = (started_at - finished_at).to_i.abs

    hours = seconds_diff / 3600
    seconds_diff -= hours * 3600

    minutes = seconds_diff / 60
    seconds_diff -= minutes * 60

    seconds = seconds_diff

    "%02d:%02d:%02d" % [hours, minutes, seconds]
  end
end
