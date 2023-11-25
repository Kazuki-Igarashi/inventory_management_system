class Public::OrdersController < ApplicationController
before_action :authenticate_customer!
  # before_action :is_matching_login_user
  def new
    @order = Order.new
    @addresses = Address.all
    @issues = current_customer.issues
    
  end

  def confirm
    @issues = Issue.where(customer_id: current_customer.id)
    @sub_total = @issues.inject(0) { |sum, issue | sum += (issue.add_tax_cost * issue.stock) }
    @postage = 800
    @total = @sub_total + @postage
    
    if params["order"]["address_id"].blank?
      return redirect_to new_order_path
    end
      
    
    if  params[:order].present?
      @order = Order.new(order_params)
    else
      return redirect_to new_order_path
    end
    
    def destroy
      order = Order.find(params[:id])
      order.destroy
      redirect_to orders_path
    end

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
        # order_detail.issue_image = issue.receiving_stock.image
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
    @orders = Order.where(customer_id: current_customer.id).order(created_at: :desc)
    
  end

  def show
    @order = Order.find(params[:id])
    # @sub_total = @oorder_detail.total_amount * amount
    @postage = 800
    # @total = @sub_total + @postage
    @total = 0;
      @order.order_details.each do |order_detail|
        @sub_total = order_detail.total_amount
    end
    @total = @sub_total + @postage
  end


  private

  def order_params
    params.require(:order).permit(:address_id)
  end

end
