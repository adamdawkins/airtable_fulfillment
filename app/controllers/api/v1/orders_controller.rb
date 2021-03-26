# frozen_string_literal: true

class Api::V1::OrdersController < Api::BaseController
  def update
    @order = Order.find_or_create_by(airtable_id: params[:id])

    if @order.update(order_params)
      render json: @order.to_json
    else
      render json: { errors: order.errors }
    end
  end

  private

  # Only allow a trusted parameter "white list" through.
  def order_params
    params.require(:order).permit(:name, :status, :customer_name, :airtable_id)
  end
end
