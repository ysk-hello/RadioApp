Rails.application.routes.draw do
  root 'programs#index'
  
  get 'programs/index'
  post 'programs/index'

  get 'programs/show'
  get 'programs/:id', to: 'programs#show'
  
  post 'messages/create'
  post 'messages/delete', to: 'messages#destroy'
end
