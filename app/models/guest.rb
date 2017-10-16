class Guest < ApplicationRecord
  has_many :schedules, :dependent => :destroy
  validates :name, :presence => true, :uniqueness => true
  validates :accesscode, :uniqueness => true
end
