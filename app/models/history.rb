class History < ActiveRecord::Base

  serialize :before, Hash
  serialize :after, Hash

  scope :todays, where(["created_at >= ?", Date.today.to_time.utc])
  scope :yesterdays, where(["created_at >= ? AND created_at < ?", (Date.today-1).to_time.utc, Date.today.to_time.utc])

  scope :with_date_range, lambda { |start_at, end_at|
    where(["created_at >= ? AND created_at < ?", start_at.utc, end_at.utc])
  }

  scope :with_editors, lambda{ |models, type|
    where(:history_editable_id => [models].flatten.collect(&:id), :history_editable_type => type)
  }

  scope :with_models, lambda { |models, type|
    where(:historical_id => [models].flatten.collect(&:id), :historical_type => type)
  }


  belongs_to :history_editable, :polymorphic => true
  belongs_to :historical, :polymorphic => true

  validates_presence_of :item_type, :historical_id, :historical_type

  class << self
    def record_changes(model, extra_options = {})
      editor = Thread.current[:current_user]
      options = (model.class.try(:history_options)||{}).merge(extra_options)
      after_hash = remove_unwanted_fields(options, model.attributes.dup)
      if model.changed_attributes.key?("id") || options[:add]
        before_hash = {}
      else
        before_hash = remove_unwanted_fields(options, after_hash.merge(model.changed_attributes.dup))
      end
      item_type = model.class.to_s
      if (after_hash != before_hash || options[:remove]) && editor
        parent_model = options[:parent].present? ? options[:parent] : model

        history = new(:item_type => item_type, :history_editable => editor)
        if parent_model
          history.historical_type = parent_model.class.to_s
          history.historical_id = parent_model.id
        end
        history.before = options[:remove] ? after_hash : before_hash
        history.after = options[:remove] ? {} : after_hash

        #If the model's history is stored on a parent, and the parent changes
        #Instead add a 'remove' history row for the old parent, and an 'add' for the new parent
        key = options[:associations_and_keys] && options[:associations_and_keys][options[:association]]
        if history.before.any? && history.after.any? && key && history.before[key] != history.after[key]
          if history.before[key]
            old_parent = history.before_model.send(options[:association])
            create(:item_type => item_type, :historical_type => old_parent.class.to_s,
                   :historical_id => old_parent.id, :history_editable => editor,
                   :after => {}, :before => history.before)
          end
          history.before = {} if history.after[key]
        end
        history.save
      end
    end

    def remove_unwanted_fields(options, changes)
      changes.symbolize_keys!

      changes.keys.each do |k|
        if changes[k].kind_of?(Symbol)
          changes[k] = changes[k].to_s
        elsif changes[k].nil?
          changes.delete(k)
        end
      end
      [(options[:except]||[]), [:ar_association_key_name, :updated_at, :created_at]].flatten.each do |unwanted_field|
        changes.delete(unwanted_field.intern)
      end
      if options[:only]
        changes.delete_if{|k, v| !options[:only].include?(k) }
      end
      return changes
    end

  end

  def before_model
    return @before_model if @before_model
    @before_model = item_type.constantize.new(before)
    @before_model.readonly!
    primary_key = @before_model.class.primary_key
    @before_model[primary_key] = before[primary_key.to_sym]
    @before_model
  end

  def after_model
    return @after_model if @after_model
    @after_model = item_type.constantize.new(after)
    @after_model.readonly!
    primary_key = @after_model.class.primary_key
    @after_model[primary_key] = after[primary_key.to_sym]
    @after_model
  end

  def display_label(what)
    case what
    when :dependent
      (after.empty? ? before_model : after_model).history_label historical
    when :model
      historical.history_label
    when :editor
      history_editable.history_label
    end
  end

end
