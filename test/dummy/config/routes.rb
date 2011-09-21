Rails.application.routes.draw do

  mount HistoryEngine::Engine => "/history_engine"
end
