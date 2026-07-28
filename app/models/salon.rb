class Salon < ApplicationRecord
  has_many :treatments, dependent: :restrict_with_error

  validates :name, presence: true
end