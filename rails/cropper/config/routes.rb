Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "url_crops#new"
<<<<<<< HEAD
  resources :url_crops
=======
  resources :url_crops, only: [:new, :create]
>>>>>>> cropper
  # redirect if unknown url
  get '*path', to: 'url_crops#must_be_redirected'
end
