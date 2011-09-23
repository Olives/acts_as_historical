module ActsAsHistorical

  # Must be called exactly once
  def editor_for_historical(options = {})
    class_eval {
      include ActsAsHistorical::Display
      has_many :histories, :foreign_key => "editor_id"
    }

    History.class_eval {
      belongs_to :editor, :class_name => "#{self}", :foreign_key => "editor_id"
    }
  end

  #options:
  # track_association: whenever an association record is added or removed, a record will be saved
  # except: array fields that shouldn't be saved.
  # only: An array of the only fields that should be saved
  def acts_as_historical(options = {})
    define_history_options(options)
    [options[:track_association]].flatten.each do |association|
      reflect_on_association(association).options[:before_add] = :record_add_dependent
      reflect_on_association(association).options[:before_remove] = :record_remove_dependent
    end

    after_save :record_history
    class_eval {
      include ActsAsHistorical::Display
      include ActsAsHistorical::SaveHistory
    }
  end

  #options:
  # except: array fields that shouldn't be saved.
  # only: An array of the only fields that should be saved

  def acts_as_historical_dependent(dependants, options={})
    define_history_options(options)
    [dependants].flatten.each do |dependent|
      after_save do |record|
        record_dependent_history(record, dependent)
      end
    end
    class_eval {
      include ActsAsHistorical::Display
      include ActsAsHistorical::SaveHistory
    }
  end

  private
  def define_history_options(options)
    options[:except] ||= []
    options[:except].concat reflect_on_all_associations(:belongs_to).collect(&:foreign_key)
    define_method(:history_options) do
      options
    end
  end

end
