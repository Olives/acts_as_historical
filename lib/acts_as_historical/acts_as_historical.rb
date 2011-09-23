module ActsAsHistorical

  def editor_for_historical(options = {})
    class_eval {
      include ActsAsHistorical::Display
    }
  end

  #options:
  # store_on: array of methods that return some active record object
  # except: array fields that shouldn't be saved.
  # only: An arra of the only fields that should be saved

  # Any belongs_to relation either needs to be an editor, have history_saved on it, or have the foreign key not saved

  def acts_as_historical(options = {})
    after_save do |record|
      History.record_changes(options, record, record.changed_attributes.dup, Thread.current[:actual_user])
    end
    before_destroy do |record|
      History.dependent_destory(options.merge(:deleted => true), record,
                                   record.changed_attributes.dup, Thread.current[:actual_user])
    end
    class_eval {
      include ActsAsHistorical::Display
    }
  end


end
