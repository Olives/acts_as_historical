require "acts_as_historical/engine"
require "acts_as_historical/historical"
require "acts_as_historical/save_history"
require "acts_as_historical/display"

ActiveRecord::Base.extend ActsAsHistorical
