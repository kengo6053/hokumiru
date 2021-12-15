Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'topics/top' => 'topics#top'
  delete 'topics/delete/:id' => 'topics#delete', as: :topic_delete
  post 'comments/create' => 'comments#create', as: :comment_create
  root to:'topics#index'

  resources :topics
  
  resources :comments, only: [:create]
  
  root 'topics#top'

end
