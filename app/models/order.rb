# frozen_string_literal: true

class Order < ActiveRecord::Base
  validates :user_name, :phone_number, :email, :address,
            :payment_status, :delivery_status,
            :payment_method, :delivery_method,
            :order_status, :order_items,
            :total_price, presence: true

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :phone_number, format: { with: /\A\d{10,15}\z/, message: "must be a valid phone number" }
  validates :total_price, numericality: { greater_than_or_equal_to: 0 }
end
