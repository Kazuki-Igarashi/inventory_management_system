class Public::OrdersController < ApplicationController
before_action :authenticate_customer!
  
  def new
    @order = Order.new
    @addresses = Address.all
  end

  def confirm
    @cart_items = CartItem.where(customer_id: current_customer.id)
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

      @issues = Issue.where(customer_id: current_customer.id)
      # @sub_total = @cart_items.inject(0) { |sum, issue| sum + issue.subtotal }
      @postage = 800
      # @total = total += issue.selling_price * issue.stock + @postage

      @issues.each do |issue|
        order_detail = OrderDetail.new
        order_detail.issue_id = issue_id
        order_detail.order_id = @order.id
        order_detail.quantity = issue.stock
        order_detail.tax_price = @total
        # order_detail.production_status = 0
        order_detail.save
      end

      @issues.destroy_all

      redirect_to orders_thanks_path

    end
  end

  def thanks
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
    params.require(:order).permit(:name, :address, :tax_price, :payment_method,:address,:post_code, :total_payment, :shipping_cost, :status)
  end

end
