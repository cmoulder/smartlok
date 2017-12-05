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
    guest = Guest.where(:accesscode => userkey).first

    # ************
    #Anti Brute Force
    if  Log.last(5).pluck(:status).any? {|item| "Access Granted".include? item}
      #Key Exists?
      if guest == nil
        newlog(guest.try(:name),userkey,"Access Denied")
        redirect_to("/home", :alert => "Access Denied.")
      else
        if guest.notify
          @guest = guest
          @admin = User.first
          @setting = Setting.first
          UserMailer.notify(@guest, @admin, @setting).deliver_later
        end

         #Number of Entries
        if !(guest.allowedcount == 0 || Log.where(:gid => guest.id, :status => "Access Granted").count < guest.allowedcount)
          newlog(guest.name,userkey,"No More Entries")
          redirect_to("/home", :alert => "Access Denied. No More Entries Allowed.")
          #Location
        elsif !(guest.geo == false || distance(userlat, userlon, setting.lat, setting.lon) < setting.radius)
          newlog(guest.name,userkey,"Invalid Location")
          redirect_to("/home", :alert => "Access Denied. You must allow location access and be near the lock.")
          #Expire
        elsif !(guest.expire == nil || guest.expire >= Time.now.strftime("%F").to_date)
          newlog(guest.name,userkey,"Access Expired")
          redirect_to("/home", :alert => "Access Denied. Your access has expired.")
          #Schedule
        elsif !(guest.unrestricted == true || schedule(guest))
          newlog(guest.name,userkey,"Outside Schedule")
          redirect_to("/home", :alert => "Access Denied. You are outside the designated schedule.")
        else
          newlog(guest.name,userkey,"Access Granted")
          unlock()
          redirect_to("/home", :notice => "Access Granted.")
        end
      end

    else
      newlog(guest.try(:name),userkey,"System Locked")
      redirect_to("/home", :alert => "Access Denied. System Locked. Too many bad attempts.")
    end
  end

end
