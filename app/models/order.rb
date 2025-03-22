# frozen_string_literal: true

# == Schema Information
#
# Table name: orders
#
#  id              :bigint           not null, primary key
#  address         :text
#  delivery_method :string
#  delivery_status :string
#  email           :string
#  order_items     :json
#  order_status    :string
#  payment_method  :string
#  payment_status  :string
#  phone_number    :string
#  total_price     :decimal(, )
#  user_name       :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
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
