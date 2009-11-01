class MonitorController < ApplicationController 
  def index
  end
  
  def remotes
    @remotes  = REMOTE_ASSERTS
    render :layout => false
  end
    
  def monitors
    @monitors = MY_MONITORS
  end
  
  def definitions
    @remotes  = REMOTE_ASSERTS
    @monitors = MY_MONITORS
  end
  
  def help
  end
end
