module ActsAsHistorical

  # Must be called at least once
  def editor_for_historical(options = {})
    class_eval {
      include ActsAsHistorical::Display
      has_many :history_edits, :as => :history_editable
    }

  end

  #options:
  # track_association: whenever an association record is added or removed, a record will be saved
  # except: array fields that shouldn't be saved.
  # only: An array of the only fields that should be saved

  def acts_as_historical(options = {})
    define_history_options(options)
    has_many :histories, :as => :historical
    after_save :record_history
    class_eval {
      include ActsAsHistorical::Display
      include ActsAsHistorical::SaveHistory
    }
  end

  #options:
  # except: array fields that shouldn't be saved.
  # only: An array of the only fields that should be saved

  def acts_as_historical_dependent(parents, options={})
    options[:parents_and_keys] = {}
    [parents].flatten.each do |parent|
      options[:parents_and_keys][parent] = reflect_on_association(parent).foreign_key.intern
      after_save do
        record_dependent_history(parent)
      end
      after_destroy do
        record_parent_remove(parent)
      end
    end
    define_history_options(options )
    class_eval {
      include ActsAsHistorical::Display
      include ActsAsHistorical::SaveHistory
    }
  end

  private
  def define_history_options(options)
    options[:display] ||= {}
    reflect_on_all_associations(:belongs_to).each do |assoc|
      options[:display][assoc.foreign_key.intern] = :belongs_to_display
    end
    define_method(:history_options) do
      options
    end
  end

end
