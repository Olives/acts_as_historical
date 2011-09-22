require "history_engine/engine"
require "history_engine/save_history"
require "history_engine/display"

ActiveRecord::Base.extend HistoryEngine
