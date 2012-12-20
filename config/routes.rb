PtSummaryReports::Application.routes.draw do
  
  authenticated :user do
    root :to => 'pt_accounts#index'
  end
  
  devise_for :users, path: 'accounts'

  resources :pt_report_receivers, only: :destroy    

  resources :pt_accounts do
    resources :pt_report_schedules, except: [:index, :show, :new]
  end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'home#index'

  unless Rails.application.config.consider_all_requests_local
    match '*not_found', to: 'errors#error_404'
  end
end
