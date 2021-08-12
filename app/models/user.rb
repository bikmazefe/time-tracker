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
        .sum(:duration)
    else
      entries.sum(:duration)
    end
  end
end
