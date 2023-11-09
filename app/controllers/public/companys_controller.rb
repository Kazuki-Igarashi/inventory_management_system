class Public::CompanysController < ApplicationController
  # before_action :authenticate_customer!

  def index
    @companys = Company.all
    @company = Company.new
  end

  def create
    @company = Company.new(address_params)
    @company.customer_id = current_customer.id
    if @company.save
      flash[notice] = "登録に成功しました"
      redirect_to addresses_path
    else
      @addresses = current_customer.company
      flash.now[alert] =  "登録に失敗しました"
      render :index
    end
  end

  def destroy
    company = Company.find(params[:id])
    company.destroy
    redirect_to companys_path
  end

  def edit
    @company = Company.find(params[:id])
  end

  def update
    @company = Companys.find(params[:id])
    if  @company.update(company_params)
      flash[notice] = "編集に成功しました"
      redirect_to companys_path
    else
      flash.now[alert] = "編集に失敗しました"
      render :edit
    end
  end

  private
  def company_params
    params.require(:company).permit(:name)
  end
end
