class Entry < ApplicationRecord
  belongs_to :user

  validates_presence_of :started_at, :entry_type

  scope :by_user, lambda { |ids| where(user_id: ids) }
  scope :at_between, lambda { |from, to| finished.where(finished_at: from.beginning_of_day..to.end_of_day) }
  scope :ongoing, -> { where(finished_at: nil) }
  scope :finished, -> { where.not(finished_at: nil) }

  def duration
    seconds_diff = (started_at - (finished_at || DateTime.now)).to_i.abs

    hours = seconds_diff / 3600
    seconds_diff -= hours * 3600

    minutes = seconds_diff / 60
    seconds_diff -= minutes * 60

    seconds = seconds_diff

    "%02d:%02d:%02d" % [hours, minutes, seconds]
  end

  def self.filter(query_param)
    if query_param
      from_date = query_param[:from].empty? ? Date.today - 10.years : Date.parse(query_param[:from])
      to_date = query_param[:to].empty? ? Date.today + 10.years : Date.parse(query_param[:to])
      entries = Entry.at_between(from_date, to_date)

      if query_param[:user_ids] && !query_param[:user_ids].empty?
        entries = entries.by_user(query_param[:user_ids])
      end

      if !query_param[:entry_type].empty?
        entries = entries.where(entry_type: query_param[:entry_type])
      end

      entries
    else
      Entry.finished
    end
  end
end
