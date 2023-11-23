class Admin::AddressesController < ApplicationController
  def index
    @addresses = Address.all.order(created_at: :desc)
    @address = Address.new
  end

  

  private
  def address_params
    params.require(:address).permit(:post_code, :address, :name)
  end
end
