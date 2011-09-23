class HistoryEngine::HistoryController < ApplicationController

  before_filter :object_lookup
  before_filter :filter_object
  before_filter :date_range_parse


  def for_editor
    @by = "editor"
    @history = ActionHistory.includes(:history_recordable).order("created_at DESC").with_editor(@history_obj)
    date_range_query
    @models = Hash.new{|h,k| h[k]=Hash.new(&h.default_proc)}
    @class_mapping = Hash.new{|h,k| h[k]=Hash.new(&h.default_proc)}
    @history.each do |h|
      obj = h.history_recordable
      @models[obj.history_type][obj.history_display] =  obj.id
      @class_mapping[obj.class.to_s.underscore][obj.history_type] = obj.id
    end
    if @query_obj
      @history = @history.includes(:history_dependable).with_model(@query_obj)
    end
    @models.keys.each{|key| @models[key].sort_by{|k,v| k.downcase}}
    @models = @models.sort_by{|k,v| k.downcase}
  end

  def for_model
    @by = "model"
    @history = ActionHistory.includes(:history_editor).order("created_at DESC").with_model(@history_obj)
    date_range_query
    @editors = Hash.new{|h,k| h[k]=Hash.new(&h.default_proc)}
    @class_mapping = Hash.new{|h,k| h[k]=Hash.new(&h.default_proc)}
    @history.each do |h|
      obj = h.history_editor
      @editors[obj.history_type][obj.history_display] =  obj.id
      @class_mapping[obj.class.to_s.underscore][obj.history_type] = obj.id
    end
    @editors.keys.each{|key| @editors[key].sort_by{|k,v| k.downcase}}
    @editors = @editors.sort_by{|k,v| k.downcase}
    if @query_obj
      @history = @history.includes(:history_dependable).with_editor(@query_obj)
    end
  end

  private

  def date_range_query
    if @start_date
      if @end_date
        @history = @history.with_date_range(@start_date.to_time, @end_date.to_time.end_of_day)
      else
        @history = @history.with_date_range(@start_date.to_time, @start_date.to_time.end_of_day)
      end
    end
  end

  def object_lookup
    @history_obj = params[:type].downcase.classify.constantize.find params[:id]
    if params[:query_type].present? && params[:query_id].present?
      @query_obj = params[:query_type].downcase.classify.constantize.find params[:query_id]
    end
  end

  def date_range_parse
    @date_range = params[:date_range] || Date.yesterday.to_s
    if @date_range.present?
      @start_date, @end_date = @date_range.split(" to ")
    end
  end

  #If a user isn't allow to access this object then this is where you can stop them
  def filter_object
    # redirect_to(root_url, :notice => "Do not have permission") and return
  end


end
