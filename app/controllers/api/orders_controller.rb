# frozen_string_literal: true

module Api
  class OrdersController < ApplicationController
    before_action :set_order, only: %i[show update destroy]

    # GET /api/orders
    def index
      orders = Order.all
      render json: orders, status: :ok
    end

    # GET /api/orders/:id
    def show
      render json: @order, status: :ok
    end

    # POST /api/orders
    def create
      order = Order.new(order_params)
      if order.save
        render json: order, status: :created
      else
        render json: { errors: order.errors.full_messages }, status: :unprocessable_entity
      end
    end

    # PUT /api/orders/:id
    def update
      if @order.update(order_params)
        render json: @order, status: :ok
      else
        render json: { errors: @order.errors.full_messages }, status: :unprocessable_entity
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
      render json: { error: "Order not found" }, status: :not_found
    end

    def order_params
      params.require(:order).permit(:user_name, :phone_number, :email, :address,
                                    :payment_status, :delivery_status,
                                    :payment_method, :delivery_method,
                                    :order_status, :total_price, order_items: [])
    end
  end
end
