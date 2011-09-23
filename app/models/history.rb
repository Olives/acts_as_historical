class History < ActiveRecord::Base

  serialize :before, Hash
  serialize :after, Hash

  scope :todays, where(["created_at >= ?", Date.today.to_time.utc])
  scope :yesterdays, where(["created_at >= ? AND created_at < ?", (Date.today-1).to_time.utc, Date.today.to_time.utc])

  scope :with_date_range, lambda { |start_at, end_at|
    where(["created_at >= ? AND created_at < ?", start_at.utc, end_at.utc])
  }

  scope :with_editor, lambda{ |model|
    where(:history_editor_id => model.id, :history_editor_type => model.class.to_s)
  }

  scope :with_dependent, lambda{ |editor|
    where(:history_dependable_id => model.id, :history_dependable_type => model.class.to_s)
  }

  scope :with_model, lambda { |model|
    where(:history_recordable_id => model.id, :history_recordable_type => model.class.to_s)
  }

  belongs_to :historical, :polymorphic => true

  class << self
    def record_changes(options, model, changes, editor)
      changes.symbolize_keys!
      changed_attributes = remove_unwanted_fields(options, changes)
      changed_fields = {}
      changes.each_pair do |field, old_value|
        changed_fields["#{model.class.to_s.underscore}.#{field}"] = {:old => old_value, :new => model.send(field)}
      end

      if changed_fields.any? && editor
        histories = []
        if options[:store_on]
          [options[:store_on]].flatten.each do |who|
            histories << {:recordable => model.send(who), :dependable => model}
          end
        else
          histories << {:recordable => model, :dependable => nil }
        end
        histories.each do |h|
          ActionHistory.create(:changed_fields => changed_fields, :history_editor => editor,
                               :history_recordable => h[:recordable], :history_dependable => h[:dependable])
        end
      end
    end

    def dependent_destroy(model)

    end

    private
    def remove_unwanted_fields(options, changes)
      (options[:except]||[]).concat([:id, :updated_at, :created_at]).each do |unwanted_field|
        changes.delete(unwanted_field)
      end
      if options[:only]
        changes.delete_if{|k, v| !options[:only].include?(k) }
      end
      return changes
    end
  end

  def display_label(what)
    case what
    when :dependent
      history_dependable.history_label history_recordable if history_dependable
    when :model
      history_recordable.history_label
    when :editor
      history_editor.history_label
    end
  end

end
