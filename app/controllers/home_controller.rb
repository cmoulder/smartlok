class HomeController < ApplicationController
  # skip_before_filter :verify_authenticity_token
  skip_before_filter :authenticate_user!
  def index

    render("home/index.html.erb")
  end

  def open
    if params[:accesscode].to_i == 123
      redirect_to("/home", :notice => "Access Granted")
    else
      redirect_to("/home", :alert => "Error")
    end
    # if save_status == true
    #   redirect_to("/logs/#{@log.id}", :notice => "Log created successfully.")
    # else
    #   render("logs/new.html.erb")
    # end

  end


end
