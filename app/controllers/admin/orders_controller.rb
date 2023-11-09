class Admin::OrdersController < ApplicationController
  def new
    @order = Order.new
    @addresses = Address.all
    @issues = current_customer.issues
  end

  def confirm
    @issues = Issue.where(customer_id: current_customer.id)
    @sub_total = @issues.inject(0) { |sum, issue | sum += (issue.add_tax_cost * issue.stock) }
    # @sub_total = 
    @postage = 800
    @total = @sub_total + @postage

    @order = Order.new(order_params)

    # @order.payment_method = params[:order][:payment_method]

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
    order = current_customer.orders.new(order_params)
      # order.issue_id = issue.id
  
    if order.save!
      issues = Issue.where(customer_id: current_customer.id)
      # @sub_total = @cart_items.inject(0) { |sum, issue| sum + issue.subtotal }
      # @postage = 800
      # @total = total += issue.selling_price * issue.stock + @postage
  
      issues.each do |issue|
        
        order_detail = order.order_details.new
        order_detail.issue_name = issue.receiving_stock.name
        order_detail.stock = issue.stock
        order_detail.sales_company_name = issue.sales_company_name
        order_detail.price = issue.add_tax_cost
        order_detail.total_amount = issue.add_tax_cost * issue.stock
        order_detail.save
      end
  
      issues.destroy_all
      redirect_to completed_orders_path
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
    params.require(:order).permit(:address_id)
  end

end
