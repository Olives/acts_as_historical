module HistoryEngine
  module Display

    def history_display(model = nil)
      "#{self.class.to_s.titleize}: #{name}"
    end

  end
end

