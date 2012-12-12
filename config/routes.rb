PtSummaryReports::Application.routes.draw do
  get "home/index"

  resources :pt_report_receivers


  resources :pt_report_schedules


  resources :pt_accounts


  devise_for :users

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'home#index'
end
