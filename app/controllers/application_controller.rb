class ApplicationController < ActionController::Base
  protect_from_forgery

  layout :layout_by_resource

  def layout_by_resource
    if devise_controller? && resource_name == :account
      "accounts"
    else
      "application"
    end
  end

  def after_sign_in_path_for(resource)
    if resource.class == Account
      accounts_root_path
    else
      super
    end
  end

  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :account
      new_account_session_path
    else
      super
    end
  end  

end
