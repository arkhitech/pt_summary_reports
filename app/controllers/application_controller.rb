class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def after_sign_in_path_for(resource)
      resource.is_a?(User) ? pt_accounts_path : super
  end
  unless Rails.application.config.consider_all_requests_local
    rescue_from Exception, with: lambda { |exception| render_500 exception }
    rescue_from ActionController::RoutingError, ActionController::UnknownController, 
      ::AbstractController::ActionNotFound, ActiveRecord::RecordNotFound, with: lambda { |exception| render_404 exception }
  end
    
  private
  def render_404(exception)
    respond_to do |format|
      format.html { render template: "errors/error_404", layout: 'layouts/application', status: 404 }
      format.all { render nothing: true, status: 404 }
    end
  end
 
  def render_500(exception)
    logger.info exception.backtrace.join("\n")
    respond_to do |format|
      format.html { render template: 'errors/error_500', layout: 'layouts/application', status: 500 }
      format.all { render nothing: true, status: 500}
    end
  end  
end
