class UnlockController < ApplicationController

  def adminunlock

    @log = Log.new
    @log.name = "Admin"
    @log.accesscode = 1337
    @log.status = "Access Granted"
    @log.save
    redirect_to("/home", :notice => "Access Granted")

  end


end
