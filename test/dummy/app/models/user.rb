class User < ActiveRecord::Base

  editor_for_historical

  def history_type(model=nil)
    :admin
  end

  def history_display(model=nil)
    username
  end

end
