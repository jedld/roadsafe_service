Rails.application.routes.draw do

  get 'query' => 'query#index'
  get 'stats' => 'query#stats'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
