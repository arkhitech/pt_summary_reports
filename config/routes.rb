PtSummaryReports::Application.routes.draw do
  get "home/index"

  resources :pt_report_schedules, only: :index do
    resources :pt_report_receivers    
  end

  resources :pt_accounts, only: :index do
    resources :pt_report_schedules, except: [:index, :show, :new]
  end

  resources :users, only: :index do
    resources :pt_accounts
  end




  devise_for :users

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'home#index'
end
