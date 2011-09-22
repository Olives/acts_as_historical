Rails.application.routes.draw do

  resources :watched_models
  resources :second_watched_models
  resources :dependent_models

  mount HistoryEngine::Engine => "/history_engine"
end
