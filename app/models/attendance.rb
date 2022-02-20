class Attendance < ApplicationRecord
  # https://qiita.com/ryouzi/items/2682e7e8a86fd2b1ae47
  belongs_to :user

  validates :worked_on, presence: true
  validates :note, length: { maximum: 50 }
  
  
  validate :finished_at_is_invalid_without_a_started_at

  def finished_at_is_invalid_without_a_started_at
    errors.add(:started_at, "が必要です") if started_at.blank? && finished_at.present?
  end


end
