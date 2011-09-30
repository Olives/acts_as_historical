module ActsAsHistorical

  # Must be called at least once
  def editor_for_historical(options = {})
    class_eval {
      include ActsAsHistorical::Display
      has_many :history_edits, :as => :history_editable
    }

  end

  #options:
  # except: array fields that shouldn't be saved.
  # only: An array of the only fields that should be saved

  def acts_as_historical(options = {})
    define_history_options(options)
    has_many :histories, :as => :historical
    after_save :record_history if :changed?
    class_eval {
      include ActsAsHistorical::Display
      include ActsAsHistorical::SaveHistory
    }
  end

  #options:
  # except: array fields that shouldn't be saved.
  # only: An array of the only fields that should be saved

  def acts_as_historical_dependent(parents, options={})
    options[:associations_and_keys] = {}
    [parents].flatten.each do |parent|
      assoc = reflect_on_association(parent)
      options[:associations_and_keys][parent] = assoc ? assoc.foreign_key.intern : options[:foreign_key][:parent]
      after_save do |record|
        record.record_dependent_history(parent) if record.changed?
      end
      after_destroy do |record|
        record.record_parent_remove(parent)
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
    define_singleton_method(:history_options) do
      options
    end
  end


end
