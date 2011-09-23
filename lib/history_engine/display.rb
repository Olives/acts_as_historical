module HistoryEngine
  module Display

    def history_type(model = nil)
      self.class.to_s.titleize
    end

    def history_display(model=nil)
      name
    end

    def history_label(model = nil)
      "#{history_type(model)}: #{history_display(model)}"
    end

  end
end

