class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy

  accepts_nested_attributes_for :order_items, allow_destroy: true

  enum :status, {
    pending: 'pending',
    paid: 'paid',
    failed: 'failed',
    cancelled: 'cancelled',
    shipped: 'shipped',
    delivered: 'delivered'
  }, validate: true

  validates :status, presence: true
  validates :total_amount, presence: true, numericality: { greater_than_or_equal_to: 0 }

  before_validation :compute_total_amount

  private

  def compute_total_amount
    self.total_amount = order_items.to_a.sum { |item| (item.price || 0) * (item.quantity || 0) }
  end
end
class Order < ApplicationRecord
  belongs_to :user
end
