module HistoryEngine

  def history_editor(options = {})
    class_eval {
      include HistoryEngine::Display
    }
  end

  #options:
  # store_on: array of methods that return some active record object
  def save_history(options = {})
    after_save do |record|
      ActionHistory.record_changes(options, record, record.changed_attributes.dup, Thread.current[:actual_user])
    end
    class_eval {
      include HistoryEngine::Display
    }
  end


end
