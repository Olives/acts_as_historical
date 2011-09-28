class History < ActiveRecord::Base

  serialize :before, Hash
  serialize :after, Hash

  scope :todays, where(["created_at >= ?", Date.today.to_time.utc])
  scope :yesterdays, where(["created_at >= ? AND created_at < ?", (Date.today-1).to_time.utc, Date.today.to_time.utc])

  scope :with_date_range, lambda { |start_at, end_at|
    where(["created_at >= ? AND created_at < ?", start_at.utc, end_at.utc])
  }

  scope :with_editor, lambda{ |model|
    where(:history_editable_id => model.id, :history_editable_type => model.class.to_s)
  }

  scope :with_model, lambda { |model|
    where(:historical_id => model.id, :historical_type => model.class.to_s)
  }


  belongs_to :history_editable, :polymorphic => true
  belongs_to :historical, :polymorphic => true

  class << self
    def record_changes(options, model)
      editor = Thread.current[:actual_user]
      after_hash = remove_unwanted_fields(options, model.attributes.dup)
      if model.changed_attributes.key?("id") || options[:add]
        before_hash = {}
      else
        before_hash = remove_unwanted_fields(options, after_hash.merge(model.changed_attributes.dup))
      end
      item_type = model.class.to_s

      if (after_hash != before_hash || options[:remove]) && editor
        parent_model = history_model(model, options[:parent])
        history = new(:item_type => item_type, :historical_type => parent_model.class.to_s,
                      :historical_id => parent_model.id, :history_editable => editor)
        history.before = options[:remove] ? after_hash : before_hash
        history.after = options[:remove] ? {} : after_hash

        #If the model's history is stored on a parent, and the parent changes
        #Instead add a 'remove' history row for the old parent, and an 'add' for the new parent
        save_history = true
        if history.before.any? && history.after.any? && options[:parents_and_keys]
          key = options[:parents_and_keys][options[:parent]]
          if history.before[key] != history.after[key]
            history.before_model.record_parent_remove(options[:parent]) if history.before[key]
            history.after_model.record_parent_add(options[:parent]) if history.after[key]
            save_history = false
          end
        end
        history.save if save_history
      end
    end

    def remove_unwanted_fields(options, changes)
      changes.symbolize_keys!

      [options[:except]||[], [:updated_at, :created_at]].flatten.each do |unwanted_field|
        changes.delete(unwanted_field.intern)
      end
      if options[:only]
        changes.delete_if{|k, v| !options[:only].include?(k) }
      end
      return changes
    end

    def history_model(model, option)
      case option
      when ActiveRecord::Base
        option
      when Symbol
        model.send(option)
      else
        model
      end
    end

  end

  def before_model
    return @before_model if @before_model
    @before_model = item_type.constantize.new(before)
    @before_model.readonly!
    @before_model.id = before[:id]
    @before_model
  end

  def after_model
    return @after_model if @after_model
    @after_model = item_type.constantize.new(after)
    @after_model.readonly!
    @after_model.id = after[:id]
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
