Rails.application.routes.draw do

  resources :watched_models
  resources :second_watched_models
  resources :dependent_models

  mount ActsAsHistorical::Engine => "/history_engine"
end
