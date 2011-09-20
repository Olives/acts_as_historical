Rails.application.routes.draw do

  mount History::Engine => "/history"
end
