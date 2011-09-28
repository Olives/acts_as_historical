module ActsAsHistorical

  module SaveHistory

    #For has and belongs to many associations
    def record_add_dependent(dependent)
      History.record_changes(dependent, :parent => self, :add => true)
    end

    def record_remove_dependent(dependent)
      History.record_changes(dependent, :parent => self, :remove => true)
    end

    def record_history
      History.record_changes(self)
    end

    def record_dependent_history(association)
      History.record_changes(self, :parent => self.send(association), :association => association )
    end

    def record_parent_remove(association)
      History.record_changes(self, :parent =>  self.send(association), :remove => true, :association => association)
    end

  end
end
