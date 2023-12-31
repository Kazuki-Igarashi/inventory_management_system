class Public::ShippingInformationsController < ApplicationController
  before_action :authenticate_customer!
  # before_action :is_matching_login_user
  def index
    @issues = current_customer.issues
    @shipping_informations = ShippingInformation.all
    # @total = @issues.inject(0) { |sum, issue| sum + issue.subtotal }
    # @total = issue.selling_price * issue.stock
  end
  
  def create
   @shipping_informations = current_customer.shipping_informations.new(shipping_information_params)
  # カート内に同じ商品がある場合数量を追加、更新保存する
    if current_customer.shipping_informations.find_by(receiving_stock_id: params[:shipping_informations][:receiving_stock_id]).present?
      # 元々カート何あるもの[:item_id]
      # 今追加したparams[:cart_item][:item_id]
      shipping_information = current_customer.shipping_informations.find_by(receiving_stock_id: params[:shipping_informations][:receiving_stock_id])
      shipping_information.amount += params[:shipping_informations][:stock].to_i
      shipping_informations.save
      flash[:notice] = "Cart item was successfully destroyed."
      redirect_to shipping_informations_path
    elsif @cart_item.save
      @shipping_informations = current_customer.shipping_informations.all
      redirect_to shipping_informations_path
    else
      redirect_to receiving_stocks_path(receiving_stocks_id)
    end
  end
  
  def update
    @shipping_informations = ShippingInformation.find(params[:id])
    @shipping_informations.update(shipping_information_params)
    flash[:notice] = 'Cart item update successfully'
    redirect_to items_path
  end
  
  private
  def shipping_informations_params
    params.require(:shipping_informations).permit(:issue_id, :stock)
  end
end
