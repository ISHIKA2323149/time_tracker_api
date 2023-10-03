Rails.application.routes.draw do
  resources :users do
    resources :check_ins, only: [:create]
    resources :breaks
    resources :checkouts, only: [:create] 
    get 'work_time', to: 'work_time#current_total_work_time'
  end
end