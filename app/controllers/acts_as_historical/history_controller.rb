class ActsAsHistorical::HistoryController < ApplicationController

  before_filter :object_lookup
  before_filter :filter_object
  before_filter :date_range_parse


  def for_editor
    @by = "editor"
    @history = History.includes(:historical).order("created_at DESC").with_editors(@history_obj, @history_type)
    date_range_query
    @models = Hash.new{|h,k| h[k]=Hash.new(&h.default_proc)}
    @class_mapping = Hash.new{|h,k| h[k]=Hash.new(&h.default_proc)}
    @history.each do |h|
      obj = h.historical
      @models[obj.history_type][obj.history_display] =  obj.id
      @class_mapping[obj.class.to_s.underscore][obj.history_type] = obj.id
    end
    if @query_objs
      @history = @history.with_models(@query_objs, @query_type)
    end
    @models.keys.each{|key| @models[key].sort_by{|k,v| k.downcase}}
    @models = @models.sort_by{|k,v| k.downcase}
  end

  def for_model
    @by = "model"
    @history = History.includes(:history_editable).order("created_at DESC").with_models(@history_obj, @history_type)
    date_range_query
    @editors = Hash.new{|h,k| h[k]=Hash.new(&h.default_proc)}
    @class_mapping = Hash.new{|h,k| h[k]=Hash.new(&h.default_proc)}
    @history.collect(&:history_editable).
      group_by{|g| [g.history_type, g.history_label, g.class.to_s.underscore]}.
      each_pair do |a, objs|
      type, display, klass = a
      ids = objs.collect(&:id).join(",")
      @editors[type][display] =  ids
      @class_mapping[klass][type] = ids
    end
    @editors.keys.each{|key| @editors[key].sort_by{|k,v| k.downcase}}
    @editors = @editors.sort_by{|k,v| k.downcase}
    if @query_obj
      @history = @history.with_editors(@query_objs, @query_type)
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
    @history_type = params[:type].downcase.classify
    @history_obj = @history_type.constantize.find params[:id]
    if params[:query_type].present? && params[:query_id].present?
      @query_type = params[:query_type].downcase.classify
      @query_objs = @query_type.constantize.where :id => params[:query_id].split(",")
    end
  end

  def date_range_parse
    @date_range = params[:date_range] || Time.now.utc.to_date.to_s
    if @date_range.present?
      @start_date, @end_date = @date_range.split(" to ")
    end
  end

  #If a user isn't allow to access this object then this is where you can stop them
  def filter_object
    # redirect_to(root_url, :notice => "Do not have permission") and return
  end


end
