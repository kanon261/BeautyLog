class Treatment < ApplicationRecord
  belongs_to :salon
  enum :category, { eyebrow: 0, eyelash_perm: 1, nail: 2, hair: 3 }
  has_one_attached :photo

  validates :category, presence: true
  validates :treatment_date, presence: true
  validates :price, numericality: { greater_than: 0 }

  before_validation :set_next_due_date, on: :create

  validate :treatment_date_cannot_be_in_the_future
  validate :next_due_date_cannot_be_before_treatment_date

  private

  def set_next_due_date
    return if next_due_date.present?
    return if category.blank? || treatment_date.blank?
    treatment_type = TreatmentType.find_by(category: category)
    return if treatment_type.blank?
    self.next_due_date = treatment_date + treatment_type.standard_cycle_days.days
  end

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

  public

  CATEGORY_LABELS = {
    "eyebrow" => "眉毛ワックス",
    "eyelash_perm" => "まつげパーマ",
    "nail" => "ネイル",
    "hair" => "美容室"
  }.freeze

  def category_label
    CATEGORY_LABELS[category]
  end
end