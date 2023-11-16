Rails.application.routes.draw do
  get 'programs/index'
  get 'programs/show'
  get 'programs/:id', to: 'programs#show'
  
  post 'messages/create'
  get 'messages/delete/:id/:pwd', to: 'messages#destroy'
end
