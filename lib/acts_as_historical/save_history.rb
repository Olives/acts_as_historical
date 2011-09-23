module ActsAsHistorical

  module SaveHistory

    def record_add_dependent(dependent)
      History.record_changes(history_options.merge(:store_on => self, :add => true), dependent)
    end

    def record_remove_dependent(dependent)
      History.record_changes(history_options.merge(:store_on => self, :remove => true), dependent)
    end

    def record_history(record)
      History.record_changes(history_options, self, changed_attributes)
    end

    def record_dependent_history(record, dependent)
      History.record_changes(history_options.merge(:store_on => record), dependent, changed_attributes)
    end
  end
end
