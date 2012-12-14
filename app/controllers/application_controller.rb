class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def after_sign_in_path_for(resource)
      resource.is_a?(User) ? user_pt_accounts_path(resource) : super
  end
end
