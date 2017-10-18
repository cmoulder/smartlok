class HomeController < ApplicationController
  # skip_before_filter :verify_authenticity_token
  skip_before_filter :authenticate_user!
  def index

    render("home/index.html.erb")
  end

  def open
    # Radians per degree
    def self.rpd(num)
      num * Math::PI / 180
    end

    #Haversine formula to give distance between two points in feet
    def distance(userlat, userlon, homelat, homelon)
      dlon = homelon - userlon
      dlat = homelat - userlat
      a = (Math.sin(rpd(dlat)/2))**2 + Math.cos(rpd(userlat)) * Math.cos((rpd(homelat))) * (Math.sin(rpd(dlon)/2))**2
      c = 2 * Math.atan2( Math.sqrt(a), Math.sqrt(1-a)) * 3956 * 5280
      return c
    end

    dist = distance(params[:lat].to_f, params[:lon].to_f, Setting.find(1).lat, Setting.find(1).lon)

    if Guest.where(:accesscode => params[:accesscode].to_i).count > 0
      @log = Log.new
      @log.name = Guest.where(:accesscode => 123).pluck(:name)[0]
      @log.accesscode = params[:accesscode]
      @log.status = "Access Granted"
      @log.save
      redirect_to("/home", :notice => "Access Granted")
    else
      @log = Log.new
      @log.name = "N/A"
      @log.accesscode = params[:accesscode]
      @log.status = "Access Denied"
      @log.save
      redirect_to("/home", :alert => "Access Denied")
    end

  end

end
