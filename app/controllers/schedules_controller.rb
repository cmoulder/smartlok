class SchedulesController < ApplicationController
  def index
    @schedules = Schedule.all

    render("schedules/index.html.erb")
  end

  def show
    @schedule = Schedule.find(params[:id])

    render("schedules/show.html.erb")
  end

  def new
    @schedule = Schedule.new

    render("schedules/new.html.erb")
  end

  def create
    @schedule = Schedule.new


    @schedule.guest_id = params[:guest_id]

    @schedule.day = params[:day]

    @schedule.start_time = params[:start_time]

    @schedule.stop_time = params[:stop_time]



    save_status = @schedule.save

    if save_status == true
      redirect_to("/schedules/#{@schedule.id}", :notice => "Schedule created successfully.")
    else
      render("schedules/new.html.erb")
    end

  end

  def edit
    @schedule = Schedule.find(params[:id])

    render("schedules/edit.html.erb")
  end

  def update
    @schedule = Schedule.find(params[:id])


    @schedule.guest_id = params[:guest_id]

    @schedule.day = params[:day]

    @schedule.start_time = params[:start_time]

    @schedule.stop_time = params[:stop_time]



    save_status = @schedule.save

    if save_status == true
      redirect_to("/schedules/#{@schedule.id}", :notice => "Schedule updated successfully.")
    else
      render("schedules/edit.html.erb")
    end

  end

  def destroy
    @schedule = Schedule.find(params[:id])

    @schedule.destroy

    if URI(request.referer).path == "/schedules/#{@schedule.id}"
      redirect_to("/", :notice => "Schedule deleted.")
    else
      redirect_to(:back, :notice => "Schedule deleted.")
    end
  end
end
