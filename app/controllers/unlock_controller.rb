class UnlockController < ApplicationController

  def adminunlock
    newlog("Admin",1337,"Access Granted")
    unlock()
    redirect_to("/home", :notice => "Access Granted")

  end


end
