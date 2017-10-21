class GuestsController < ApplicationController
  def index
    @guests = Guest.all

    render("guests/index.html.erb")
  end

  def send_email
    @guest = Guest.find(params[:id])
    UserMailer.access_granted(@guest, Setting.first).deliver_later
  end

  def show
    @guest = Guest.find(params[:id])

    render("guests/show.html.erb")
  end

  def new
    @guest = Guest.new

    render("guests/new.html.erb")
  end

  def create
    @guest = Guest.new


    @guest.name = params[:name]

    @guest.email = params[:email]

    @guest.accesscode = params[:accesscode]

    @guest.allowedcount = params[:allowedcount]

    if params[:unrestricted] == "on"
      @guest.unrestricted = true
    else
      @guest.unrestricted = false
    end

    if params[:geo] == "on"
      @guest.geo = true
    else
      @guest.geo = false
    end



    save_status = @guest.save

    if save_status == true
      redirect_to("/guests/#{@guest.id}/edit", :notice => "Guest created successfully.")
    else
      render("guests/new.html.erb")
    end

  end

  def edit
    @guest = Guest.find(params[:id])
    @schedules = @guest.schedules

    render("guests/edit.html.erb")
  end

  def update
    @guest = Guest.find(params[:id])

    @guest.name = params[:name]

    @guest.email = params[:email]

    @guest.accesscode = params[:accesscode]

    @guest.allowedcount = params[:allowedcount]

    if params[:unrestricted] == "on"
      @guest.unrestricted = true
    else
      @guest.unrestricted = false
    end

    if params[:geo] == "on"
      @guest.geo = true
    else
      @guest.geo = false
    end

    save_status = @guest.save

    if save_status == true
      redirect_to("/guests/#{@guest.id}/edit", :notice => "Guest updated successfully.")
    else
      render("guests/edit.html.erb")
    end

  end

  def destroy
    @guest = Guest.find(params[:id])

    @guest.destroy

    if URI(request.referer).path == "/guests/#{@guest.id}"
      redirect_to("/", :notice => "Guest deleted.")
    else
      redirect_to(:back, :notice => "Guest deleted.")
    end
  end
end
