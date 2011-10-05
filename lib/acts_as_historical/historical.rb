module ActsAsHistorical

  # Marks the model as the editor for all of the histories
  def editor_for_historical(options = {})
    class_eval {
      include ActsAsHistorical::Display
      has_many :history_edits, :as => :history_editable
    }

  end

  #options:
  # except: array fields that shouldn't be saved.
  # ignore: array of fields that will be saved, but never displayed in the ui.
  #   this is useful for association data that is used to display other data, but itself doesn't change.
  #   For instance, a belongs_to association that never changes would be a good choice to put here.
  # only: An array of the only fields that should be saved
  # display: an hash of {attribute => method} where in the UI, instead of just displaying the attribute, it will
  #   call the method given on the model created.
  #   This is again useful for associations, so instead of displaying model_id = 1,
  #   you might want to display model = "model's name"
  def acts_as_historical(options = {})
    define_history_options(options)
    has_many :histories, :as => :historical
    after_save :record_history if :changed?
    class_eval {
      include ActsAsHistorical::Display
      include ActsAsHistorical::SaveHistory
    }
  end

  # parents can either be associations, or a method that returns a particular model.
  # options:
  #  as acts_as_historical plus:
  #  foreign_key:  hash of {parent => attribute}. Maps methods to attributes if the parent method is not an association
  #    i.e. parent can be :special_parent, and foreign_key: {:special_parent => :parent_id }
  #    Thus whenever :parent_id changes, the association will be updated.
  def acts_as_historical_dependent(parents, options={})
    options[:associations_and_keys] = {}
    [parents].flatten.each do |parent|
      assoc = reflect_on_association(parent)
      options[:associations_and_keys][parent] = assoc ? assoc.foreign_key.intern : options[:foreign_key][parent]
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
