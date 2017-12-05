class GuestsController < ApplicationController
  def index
    @guests = Guest.all

    render("guests/index.html.erb")
  end

  def send_email
    @guest = Guest.find(params[:id])
    @setting = Setting.first
    #could use deliver_later, but this seems like false advertising if we haven't tried sending yet.
    UserMailer.access_granted(@guest, @setting).deliver_now!

    redirect_to("/guests/#{@guest.id}/edit", :notice => "Message Sent.")
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

    tempdate=params[:expire].to_s
    if tempdate == ''
      @guest.expire = nil
    else
      @guest.expire = tempdate[3,2]+'/'+tempdate[0,2]+'/'+tempdate[6,4]
    end

    @guest.name = params[:name]

    @guest.email = params[:email]

    @guest.accesscode = params[:accesscode]

    @guest.allowedcount = params[:allowedcount]

    if params[:notify] == "on"
      @guest.notify = true
    else
      @guest.notify = false
    end

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
    @SORT_ORDER = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    @guest = Guest.find(params[:id])
    @schedules = @guest.schedules

    render("guests/edit.html.erb")
  end

  def update
    @guest = Guest.find(params[:id])

    tempdate = params[:expire].to_s
    if tempdate == ''
      @guest.expire = nil
    else
      @guest.expire = tempdate[3,2]+'/'+tempdate[0,2]+'/'+tempdate[6,4]
    end
    @guest.name = params[:name]

    @guest.email = params[:email]

    @guest.accesscode = params[:accesscode]

    @guest.allowedcount = params[:allowedcount]

    if params[:notify] == "on"
      @guest.notify = true
    else
      @guest.notify = false
    end

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
