class Schedule < ApplicationRecord
  belongs_to :guest
  validates :guest_id, :day, :start_time, :stop_time, :presence => true

  validate :stop_gt_start?

  def stop_gt_start?
    return if [stop_time.blank?, start_time.blank?].any?
    if start_time > stop_time
      errors.add(:stop_time, ' must be after Start time.')
    end
  end
end
