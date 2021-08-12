class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :entries

  scope :without_admins, -> { where(admin: false) }

  def entry_count_by_type(type)
    entries.where(entry_type: type).size
  end

  def total_entry_duration(from = nil, to = nil)
    if from.present? && to.present?
      entries
        .at_between(from, to)
        .collect { |e| e.duration }
        .reduce(0) { |memo, num| memo + num }
    else
      entries
        .collect { |e| e.duration }
        .reduce(0) { |memo, num| memo + num }
    end
  end
end
