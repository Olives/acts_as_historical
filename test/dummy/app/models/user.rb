class User < ActiveRecord::Base

  history_editor

  def history_type(model=nil)
    :admin
  end

  def history_display(model=nil)
    username
  end

end
