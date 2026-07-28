class Salon < ApplicationRecord
  has_many :treatments

  validates :name, presence: true
end