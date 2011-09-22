class HistoryEngine::HistoryController < ApplicationController

  before_filter :object_lookup
  before_filter :filter_object

  def for_editor
    @by = "editor"
    @history = ActionHistory.order("created_at DESC").with_editor(@history_obj)

  end

  def for_model
    @by = "model"
    @history = ActionHistory.order("created_at DESC").with_model(@history_obj)
  end

  private
  def object_lookup
    @history_obj = params[:type].downcase.classify.constantize.find params[:id]
  end

  #If a user isn't allow to access this object then this is where you can stop them
  def filter_object
    # redirect_to(root_url, :notice => "Do not have permission") and return
  end


end
