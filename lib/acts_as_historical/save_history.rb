module ActsAsHistorical

  module SaveHistory

    #For has and belongs to many associations
    def record_add_dependent(dependent)
      History.record_changes(history_options.merge(:parent => self, :add => true), dependent)
    end

    def record_remove_dependent(dependent)
      History.record_changes(history_options.merge(:parent => self, :remove => true), dependent)
    end

    def record_history
      History.record_changes(history_options, self)
    end

    def record_dependent_history(parent)
      History.record_changes(history_options.merge(:parent => parent), self)
    end

    def record_parent_add(parent)
      History.record_changes(history_options.merge(:parent => parent, :add => true), self)
    end

    def record_parent_remove(parent)
      History.record_changes(history_options.merge(:parent => parent, :remove => true), self)
    end

  end
end
