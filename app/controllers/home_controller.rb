class HomeController < ApplicationController
  # skip_before_filter :verify_authenticity_token
  skip_before_filter :authenticate_user!
  def index

    render("home/index.html.erb")
  end

  def open

    userlat = params[:lat].to_f
    userlon = params[:lon].to_f
    userkey = params[:accesscode].to_i
    setting = Setting.first

    #anti brute force
    #check key
    guest = Guest.where(:accesscode => userkey).first

    if guest != nil
      #check access count
      if guest.allowedcount == 0 || Log.where(:gid => guest.id).count < guest.allowedcount
        #check location
        if guest.geo == false || distance(userlat, userlon, setting.lat, setting.lon) < setting.radius
          if guest.unrestricted == true || schedule(guest)
            newlog(guest.name,userkey,"Access Granted")
            unlock()
            redirect_to("/home", :notice => "Access Granted")
          else
            newlog(guest.name,userkey,"Outside Schedule")
            redirect_to("/home", :alert => "Access Denied. You are outside the designated schedule.")
          end
        else
          newlog(guest.name,userkey,"Invalid Location")
          redirect_to("/home", :alert => "Access Denied. You must allow location access and be near the lock.")
        end
      else
        newlog(guest.name,userkey,"No More Entries")
        redirect_to("/home", :alert => "Access Denied. No More Entries Allowed.")
      end
    else
      newlog("N/A",userkey,"Access Denied")
      redirect_to("/home", :alert => "Access Denied")
    end
  end
end
