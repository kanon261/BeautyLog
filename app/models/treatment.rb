class Treatment < ApplicationRecord
  belongs_to :salon
  enum :category, { eyebrow: 0, eyelash_perm: 1, nail: 2, hair: 3 }

  validates :category, presence: true
  validates :treatment_date, presence: true
  validates :price, numericality: { greater_than: 0 }

  validate :treatment_date_cannot_be_in_the_future
  validate :next_due_date_cannot_be_before_treatment_date

  private

  def treatment_date_cannot_be_in_the_future
    return if treatment_date.blank?
    if treatment_date > Date.today
      errors.add(:treatment_date, "は未来の日付にできません")
    end
  end

  def next_due_date_cannot_be_before_treatment_date
    return if treatment_date.blank? || next_due_date.blank?
    if next_due_date < treatment_date
      errors.add(:next_due_date, "は施術日より前にできません")
    end
  end
end