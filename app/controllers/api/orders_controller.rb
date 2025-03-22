# frozen_string_literal: true

module Api
  class OrdersController < ApplicationController
    rate_limit to: 10, within: 3.minutes, only: [ :index, :show ], by: -> { request.ip }

    before_action :set_order, only: %i[show update destroy]

    # GET /api/orders
    def index
      orders = Order.all
      render_json_response(orders, status: :ok)
    end

    # GET /api/orders/:id
    def show
      render_json_response(@order, status: :ok)
    end

    # POST /api/orders
    def create
      order = Order.new(order_params)
      if order.save
        render_json_response(order, status: :created)
      else
        render_json_response({ errors: order.errors.full_messages }, status: :unprocessable_entity)
      end
    end

    # PUT /api/orders/:id
    def update
      if @order.update(order_params)
        render_json_response(@order, status: :ok)
      else
        render_json_response({ errors: @order.errors.full_messages }, status: :unprocessable_entity)
      end
    end

    # DELETE /api/orders/:id
    def destroy
      @order.destroy
      head :no_content
    end

    private

    def set_order
      @order = Order.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render_json_response({ error: "Order not found" }, status: :not_found)
    end

    def order_params
      params.require(:order).permit(:user_name, :phone_number, :email, :address,
                                    :payment_status, :delivery_status,
                                    :payment_method, :delivery_method,
                                    :order_status, :total_price, order_items: [ :item, :quantity, :price ])
    end
  end
end
