class LogsController < ApplicationController
  def index
    @logs = Log.all

    render("logs/index.html.erb")
  end

  def show
    @log = Log.find(params[:id])

    render("logs/show.html.erb")
  end

  def new
    @log = Log.new

    render("logs/new.html.erb")
  end

  def create
    @log = Log.new


    @log.accesscode = params[:accesscode]

    @log.status = params[:status]



    save_status = @log.save

    if save_status == true
      redirect_to("/logs/#{@log.id}", :notice => "Log created successfully.")
    else
      render("logs/new.html.erb")
    end

  end

  def edit
    @log = Log.find(params[:id])

    render("logs/edit.html.erb")
  end

  def update
    @log = Log.find(params[:id])


    @log.accesscode = params[:accesscode]

    @log.status = params[:status]



    save_status = @log.save

    if save_status == true
      redirect_to("/logs/#{@log.id}", :notice => "Log updated successfully.")
    else
      render("logs/edit.html.erb")
    end

  end

  def destroy

    Log.destroy_all

      redirect_to("/logs", :notice => "Log deleted.")
      # redirect_to(:back, :notice => "Log deleted.")
  end
end
