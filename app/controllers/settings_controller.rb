class SettingsController < ApplicationController


  def edit
    @setting = Setting.find(1)

    render("settings/index.html.erb")
  end

  def update
    @setting = Setting.find(1)


    @setting.lat = params[:lat]

    @setting.lon = params[:lon]

    @setting.radius = params[:radius]

    @setting.title = params[:title]



    save_status = @setting.save

    if save_status == true
      redirect_to("/settings", :notice => "Setting updated successfully.")
    else
      render("settings/index.html.erb")
    end

  end

end
