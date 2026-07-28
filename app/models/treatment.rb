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
  validate :photo_must_be_valid

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

  ALLOWED_PHOTO_TYPES = %w[image/png image/jpeg image/gif image/webp].freeze
  MAX_PHOTO_SIZE = 5.megabytes

  def photo_must_be_valid
    return unless photo.attached?
    unless ALLOWED_PHOTO_TYPES.include?(photo.content_type)
      errors.add(:photo, "はPNG・JPEG・GIF・WEBP形式のみアップロードできます")
    end
    if photo.byte_size > MAX_PHOTO_SIZE
      errors.add(:photo, "は5MB以下のファイルにしてください")
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

  def days_until_due
    return nil if next_due_date.blank?
    (next_due_date - Date.today).to_i
  end

  def due_status
    return :unknown if next_due_date.blank?
    days = days_until_due
    if days < 0
      :overdue
    elsif days <= 7
      :soon
    else
      :ok
    end
  end

  DUE_STATUS_LABELS = {
    overdue: "期限切れ",
    soon: "まもなく",
    ok: "余裕あり",
    unknown: "ー"
  }.freeze

  DUE_STATUS_COLORS = {
    overdue: ["#FBE1E9", "#B23E63"],
    soon: ["#FCEFDD", "#B77C1E"],
    ok: ["#E7F5EB", "#4B8B67"],
    unknown: ["#F0F0F0", "#888888"]
  }.freeze

  def due_status_label
    DUE_STATUS_LABELS[due_status]
  end

  def due_status_bg_color
    DUE_STATUS_COLORS[due_status][0]
  end

  def due_status_text_color
    DUE_STATUS_COLORS[due_status][1]
  end
end