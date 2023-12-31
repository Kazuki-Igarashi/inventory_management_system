class Public::AddressesController < ApplicationController
  # before_action :authenticate_customer!
  # before_action :is_matching_login_user
  
  def index
    @addresses = current_customer.addresses
    @address = Address.new
  end

  def create
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id
    if @address.save
      flash[notice] = "登録に成功しました"
      redirect_to addresses_path
    else
      @addresses = current_customer.addresses
      flash.now[alert] =  "登録に失敗しました"
      render :index
    end
  end

  def destroy
    address = Address.find(params[:id])
    address.destroy
    flash[alert] =  "配送先を削除しました"
    redirect_to addresses_path
  end

  def edit
    @address = Address.find(params[:id])
  end

  def update
    @address = Address.find(params[:id])
    if  @address.update(address_params)
      flash[notice] = "編集に成功しました"
      redirect_to addresses_path
    else
      flash.now[alert] = "編集に失敗しました"
      render :edit
    end
  end

  private
  def address_params
    params.require(:address).permit(:post_code, :address, :name)
  end
end
