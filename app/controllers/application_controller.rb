class ApplicationController < ActionController::Base

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :telephone_number])
  end

  private

  def after_sign_in_path_for(resource_or_scope)
    if resource_or_scope.is_a?(Admin)
      # adminユーザー
      admin_root_path

    else
      # customerユーザー
      about_path
    end
  end
  
  def guest_sign_in
    # ゲストアカウントでログイン
    sign_in Customer.guest
    # 以下を変更
    redirect_to about_path #遷移させたいページのpathを記述
  end
  
  def after_sign_up_path_for(resource_or_scope)
      
      about_path
  end
  
  # def after_sign_in_path_for(resource_or_scope)
  #   root_path
  # end

  def after_sign_out_path_for(resource_or_scope) # adminかそれ以外かでサインアウトした後の遷移先画面を分岐させる
    if resource_or_scope == :admin
      new_admin_session_path

    else
      root_path
    end
  end

end
