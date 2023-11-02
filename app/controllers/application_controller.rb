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
  
  # def after_sign_in_path_for(resource_or_scope)
  #   root_path
  # end

  def after_sign_out_path_for(resource_or_scope) # adminかそれ以外かでサインアウトした後の遷移先画面を分岐させる
    if resource_or_scope == :admin
      new_admin_session_path

    else
      about_path
    end
  end

end
