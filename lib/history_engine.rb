require "history_engine/engine"
require "history_engine/save_history"

ActiveRecord::Base.extend HistoryEngine
