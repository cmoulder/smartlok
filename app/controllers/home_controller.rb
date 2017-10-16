class HomeController < ApplicationController
  # skip_before_filter :verify_authenticity_token
  skip_before_filter :authenticate_user!
  def index

    render("home/index.html.erb")
  end

  def open
    if Guest.where(:accesscode => params[:accesscode].to_i).count > 0
      @log = Log.new
      @log.name = Guest.where(:accesscode => params[:accesscode].to_i).name
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
      redirect_to("/home", :alert => "Error")
    end
    # if save_status == true
    #   redirect_to("/logs/#{@log.id}", :notice => "Log created successfully.")
    # else
    #   render("logs/new.html.erb")
    # end

  end


end
