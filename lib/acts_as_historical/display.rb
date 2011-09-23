module ActsAsHistorical
  module Display

    def history_type
      self.class.to_s.titleize
    end

    def history_display(model=nil)
      name
    end

    def history_label(model=nil)
      I18n.t "acts_as_historical.display", :model => history_type, :value => history_display(model)
    end

  end
end

