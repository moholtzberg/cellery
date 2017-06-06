class DiscountCodeEffect < ActiveRecord::Base
  include ApplicationHelper
  
  belongs_to :code, class_name: 'DiscountCode', foreign_key: :discount_code_id
  validates :discount_code_id, presence: true

  def calculate(order)
    if shipping
      return (percent/100)*order.shipping_total_sum
    end
  end
end