#reference: http://stackoverflow.com/questions/6546173/2-render-templates-from-devise-on-one-page-rails-3
module HomeHelper
  def resource_name
    :user
  end

  def resource
    @resource = session[:subscription] || User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end  
end
