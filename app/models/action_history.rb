class ActionHistory < ActiveRecord::Base

  serialize :changed_fields, Hash

  scope :todays, where(["created_at >= ?", Date.today.to_time.utc])
  scope :yesterdays, where(["created_at >= ? AND created_at < ?", (Date.today-1).to_time.utc, Date.today.to_time.utc])

  scope :with_date_range, lambda { |start_at, end_at| where(["created_at >= ? AND created_at < ?", start_at.utc, end_at.utc])}

  scope :with_user, lambda{ |user| where(:editor_id => user.id) }

    #Call after a model has been created, but before it has been updated or destroyed
  def self.record_changes(model, changes, user)
    debugger
    changes.delete("id")
    changes.delete("updated_at")
    changes.delete("created_at")
    changed_fields = {}
    changes.each_pair do |field, old_value|
      if old_value.kind_of?(Hash)
        changed_fields[field] = old_value
      else
        changed_fields[field] = {:old => old_value, :new => model.send(field)}
      end
    end
    if changed_fields.any? && user
      ah = ActionHistory.new(:changed_fields => changed_fields)
      ah.user = user
      ah.recordable = model
      ah.save
    end
  end



end
