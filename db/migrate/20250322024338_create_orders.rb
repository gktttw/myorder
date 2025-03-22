class CreateOrders < ActiveRecord::Migration[8.0]
  def change
    create_table :orders do |t|
      t.string :user_name
      t.string :phone_number
      t.string :email
      t.text :address
      t.string :payment_status
      t.string :delivery_status
      t.string :payment_method
      t.string :delivery_method
      t.string :order_status
      t.json :order_items
      t.decimal :total_price

      t.timestamps
    end
  end
end
