Rails.application.routes.draw do

  resources :watched_models
  resources :second_watched_models
  resources :dependent_models

  history_at :history_engine

end
