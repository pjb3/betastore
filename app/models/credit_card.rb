class CreditCard < ActiveRecord::Base
  belongs_to :customer

  before_validation :normalize_card_number

  validates :customer_id, presence: true
  validates :card_number,
    presence: true,
    format: { with: /\A\d{15,16}\z/, allow_blank: true }

  validate :validate_expiration_date

  scope :expired, -> { where('expiration_date < ?', Time.current) }

  def self.expired
    where('expiration_date < ?', Time.current)
  end

  def normalize_card_number
    if card_number.present?
      self.card_number = card_number.gsub(/\D/,'')
    end
  end

  def expires_on
    @expires_on ||= Date.strptime(expiration_date, '%m/%Y') + 1.month
  end

  def validate_expiration_date
    if expiration_date.blank?
      errors.add(:expiration_date, 'is required')
    elsif expiration_date !~ /\d{2}\/\d{4}/
      errors.add(:expiration_date, 'should be in the format MM/YYYY')
    elsif expires_on < Time.current
      errors.add(:expiration_date, 'has expired')
    end
  end
end
