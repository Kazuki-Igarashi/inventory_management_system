class Public::ContractorsController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_guest_user, only: [:edit]
  def show #顧客情報表示
    @customer = current_customer
    # @user = User.find(params[:id])
  end

  def edit #顧客情報編集
    @customer = current_customer
  end

  def update #顧客情報アプデ
    @customer = current_customer
    @customer.update(customer_params)
    redirect_to mypage_contractors_path
    # if @customer.update(customer_params)
    #   flash[:update] = "You have updated user info successfully."
    #   redirect_to mypage_public_customers_path
    # else
    #   render 'edit'
    # end
  end

  def quit #退会確認画面
    @customer = current_customer
  end

  def withdraw #退会処理
    @customer = current_customer
    # is_memberカラムをtrueに変更することで削除フラグを立てる
    @customer.update(is_menber: true)
    if @customer.save
      reset_session
      flash[:notice] = "退会処理を実行しました"
      redirect_to root_path
    end
  end


  private
    def customer_params
      params.require(:customer).permit(:name, :name_kana,
                                       :email, :post_code, :address, :telephone_number, :company_name, :company_name_kana )
    end
  
  def ensure_guest_user
    @customer = Customer.find(params[:id])
    if @customer.email == "guest@example.com"
      redirect_to root_path , notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
    end
  end  
end

