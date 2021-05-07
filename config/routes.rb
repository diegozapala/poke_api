Rails.application.routes.draw do
  root 'home#index'

  get 'get_poke/:name'   , to: 'pokemon#get_poke'
end
