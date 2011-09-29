module ActionDispatch::Routing
  class Mapper

    def history_at(mount_location)
      [:editor, :model].each do |method|
        h = {controller: "acts_as_historical/history", action: "for_#{method}", as: "history_for_#{method}"}
        scope mount_location do
          match "for_#{method}/:id/:type", h
        end
      end
    end

  end

end
