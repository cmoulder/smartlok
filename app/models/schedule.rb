class Schedule < ApplicationRecord
  belongs_to :guest
  validates :guest_id, :presence => true
end
