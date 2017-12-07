class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  protected
  #require 'rpi_gpio'

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, :keys => [:email, :username, :password])
    devise_parameter_sanitizer.permit(:account_update, :keys => [:username, :email, :password, :password_confirmation])
  end

  def unlock
    # RPi::GPIO.set_numbering :board
    #
    # out1 = 16
    # out2 = 18
    #
    # RPi::GPIO.setup out1, :as => :output
    # RPi::GPIO.setup out2, :as => :output
    #
    # RPi::GPIO.set_high out1
    # sleep(0.5)
    # RPi::GPIO.set_low out1
    # sleep(1.0)
    #
    # RPi::GPIO.set_high out2
    # sleep(0.5)
    # RPi::GPIO.set_low out2
    #
    # RPi::GPIO.clean_up
  end

  # function to write log entries
  def newlog(name, accesscode, status)
    @log = Log.new
    @log.name = name
    @log.accesscode = accesscode
    @log.status = status
    @log.gid = Guest.where(:name => name).first.try(:id)
    @log.save
  end

  # Radians per degree
  def rpd(num)
    return num * Math::PI / 180
  end

  #Haversine formula to give distance between two points in feet
  def distance(userlat, userlon, homelat, homelon)
    dlon = homelon - userlon
    dlat = homelat - userlat
    a = (Math.sin(rpd(dlat)/2))**2 + Math.cos(rpd(userlat)) * Math.cos((rpd(homelat))) * (Math.sin(rpd(dlon)/2))**2
    c = 2 * Math.atan2( Math.sqrt(a), Math.sqrt(1-a)) * 3956 * 5280
    return c
  end

  #check guests schedule and return true if in alloted time.
  def schedule(guest)
    currentday = Time.now.strftime("%A")
    currenttime = Time.now.strftime("%H:%M:%S")

    goodtogo = false

    guest.schedules.each do |schentry|
      if schentry.day == currentday && schentry.start_time.strftime("%H:%M:%S") < currenttime && schentry.stop_time.strftime("%H:%M:%S") > currenttime
        goodtogo = true
      end
    end

    return goodtogo
  end

end
