Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #

  # Dangerous but easy catch-all route
  match ':controller(/:action(/:id))', via: [:get, :post] #---!!!!! DANGER !!!! SHOULD REPLACE
end
