PtSummaryReports::Application.routes.draw do
  get "home/index"

  devise_for :users, path: 'accounts'

  resources :pt_report_receivers, only: :destroy    

  resources :pt_accounts, only: [:show, :edit] do
    resources :pt_report_schedules, except: [:index, :show, :new]
  end

  resources :users, only: :index do
    resources :pt_accounts
  end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'home#index'
end
