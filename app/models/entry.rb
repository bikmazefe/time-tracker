class Entry < ApplicationRecord
  belongs_to :user

  validates_presence_of :started_at, :entry_type

  scope :by_user, lambda { |ids| where(user_id: ids) }
  scope :at_between, lambda { |from, to| finished.where(finished_at: from.beginning_of_day..to.end_of_day) }
  scope :ongoing, -> { where(finished_at: nil) }
  scope :finished, -> { where.not(finished_at: nil) }

  def duration_string
    seconds_diff = self.duration

    hours = seconds_diff / 3600
    seconds_diff -= hours * 3600

    minutes = seconds_diff / 60
    seconds_diff -= minutes * 60

    seconds = seconds_diff

    "%02d:%02d:%02d" % [hours, minutes, seconds]
  end

  def duration
    (started_at - (finished_at || DateTime.now)).to_i.abs
  end

  def self.search(query_param)
    if query_param
      from_date = query_param[:from].blank? ? Date.today - 10.years : Date.parse(query_param[:from])
      to_date = query_param[:to].blank? ? Date.today + 10.years : Date.parse(query_param[:to])
      user_ids = query_param[:user_ids].blank? ? User.without_admins.pluck(:id) : query_param[:user_ids]

      entries = Entry.at_between(from_date, to_date).by_user(user_ids)

      if query_param[:entry_type].present?
        entries = entries.where(entry_type: query_param[:entry_type])
      end

      entries
    else
      Entry.finished
    end
  end
end
