class Public::OrdersController < ApplicationController
before_action :authenticate_customer!

  def new
    @order = Order.new
  end

  def confirm
    @shipping_informations = ShippingInformation.where(customer_id: current_customer.id)
    @sub_total = @cart_items.inject(0) { |sum, item| sum + item.subtotal }
    @postage = 800
    @total = @sub_total + @postage

    @order = Order.new(order_params)

    @order.payment_method = params[:order][:payment_method]

    @address_type = params[:order][:address_type]
    case @address_type
      when "self_address"
        @selected_address = current_customer.post_code + "  " + current_customer.address + "  " + current_customer.last_name + "  " + current_customer.first_name
        @order.post_code = current_customer.post_code
        @order.address = current_customer.address
        @order.name = current_customer.last_name + current_customer.first_name
      when "registered_address"
        @selected = Address.find(params[:order][:address_id])
        @selected_address = @selected.post_code + "  " + @selected.address + "  " + @selected.name
        @order.post_code = @selected.post_code
        @order.address = @selected.address
        @order.name = @selected.name
      when "new_address"
        @selected_address = params[:order][:post_code] + "  " + params[:order][:address] + "  " + params[:order][:name]
    end
  end

  def create
    @order = current_customer.orders.new(order_params)
    @order.customer_id = current_customer.id

    if @order.save

      @shipping_informations = ShippingInformations.where(customer_id: current_customer.id)
      @sub_total = @cart_items.inject(0) { |sum, item| sum + item.subtotal }
      @postage = 800
      @total = @sub_total + @postage

      @shipping_informations.each do |shipping_information|

      end

      @shipping_informations.destroy_all

      redirect_to orders_thanks_path

    end
  end

  def completed
  end

  def index
    @orders = Order.where(customer_id: current_customer.id).order(create_at: :desc)
  end

  def show
    @order = Order.find(params[:id])
    @postage = 800
  end


  private

  def order_params
    params.require(:order).permit(:name, :address, :tax_price, :post_code, :total_payment, :shipping_cost)
  end
end
