module HistoryEngine

  def save_history(options = {})
    after_save do |record|
      ActionHistory.record_changes(record, record.changed_attributes, Thread.current[:actual_user])
    end
  end

end
