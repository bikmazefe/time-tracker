# frozen_string_literal: true

class Entry < ApplicationRecord
  before_save :set_duration

  belongs_to :user

  validates_presence_of :entry_type

  scope :at_between, ->(from, to) { finished.where(finished_at: from.beginning_of_day..to.end_of_day) }
  scope :ongoing, -> { where(finished_at: nil) }
  scope :finished, -> { where.not(finished_at: nil) }

  def start!
    update(started_at: Time.now) unless started_at.present?
  end

  def finish!
    update(finished_at: Time.now) unless finished_at.present?
  end

  def ongoing?
    finished_at.blank?
  end

  def calculate_duration
    if finished_at
      (started_at - finished_at).to_i.abs
    else
      (Time.now - started_at).to_i.abs
    end
  end

  def self.search(query_param)
    if query_param
      from_date = query_param[:from].blank? ? Date.today - 10.years : Date.parse(query_param[:from])
      to_date = query_param[:to].blank? ? Date.today + 10.years : Date.parse(query_param[:to])

      entries = Entry.at_between(from_date, to_date)

      if query_param[:entry_type].present?
        entries = entries.where(entry_type: query_param[:entry_type])
      end

      entries
    else
      Entry.finished
    end
  end

  def self.total_duration
    sum(:duration)
  end

  def self.count_by_type(type)
    where(entry_type: type).size
  end

  private

  def set_duration
    self.duration = calculate_duration unless ongoing?
  end
end
