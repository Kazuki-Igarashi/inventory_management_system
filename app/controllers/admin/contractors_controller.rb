class Admin::ContractorsController < ApplicationController
  def index
    @customers = Customer.all
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update #顧客情報アプデ
    @customer = Customer.find(params[:id])
    # @customer.update(customer_params)
    # redirect_to customer_path
    if @customer.update(customer_params)
      flash[:update] = "編集が成功しました。"
      redirect_to admin_contractor_path
    else
      render 'edit'
    end
  end

  private
  def customer_params
    params.require(:customer).permit(:name, :name_kana, :post_code, :address,
                                        :company_name, :company_name_kana, :telephone_number, :email, :is_menber)
  end
end
