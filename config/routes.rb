ActsAsHistorical::Engine.routes.draw do

  match('for_editor/:id/:type',
        :controller => :history, :action => :for_editor, :as => :history_for_editor)

  match('for_model/:id/:type',
        :controller => :history, :action => :for_model, :as => :history_for_model)


end
