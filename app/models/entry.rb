# frozen_string_literal: true

class Entry < ApplicationRecord
  before_save :set_duration

  belongs_to :user

  validates_presence_of :entry_type

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

  def self.group_by_user
    self.joins(:user).select("users.email", "entries.*").group_by(&:email)
  end

  private

  def set_duration
    self.duration = calculate_duration unless ongoing?
  end
end
