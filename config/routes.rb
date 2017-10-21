Rails.application.routes.draw do
  # Routes for the Unlock resource:

  # UPDATE
  get "/aunlock", :controller => "unlock", :action => "adminunlock"

  #------------------------------


  # Routes for the Setting resource:

  # UPDATE
  get "/settings", :controller => "settings", :action => "edit"
  post "/update_setting", :controller => "settings", :action => "update"

  #------------------------------

  devise_for :users
  # Routes for the Log resource:
  # CREATE
  get "/logs/new", :controller => "logs", :action => "new"
  post "/create_log", :controller => "logs", :action => "create"

  # READ
  get "/logs", :controller => "logs", :action => "index"
  get "/logs/:id", :controller => "logs", :action => "show"

  # UPDATE
  get "/logs/:id/edit", :controller => "logs", :action => "edit"
  post "/update_log/:id", :controller => "logs", :action => "update"

  # DELETE
  get "/delete_log", :controller => "logs", :action => "destroy"
  #------------------------------

  # Routes for the Guest resource:
  #SEND EMAIL
  get "/send_email/:id", :controller => "guests", :action => "send_email"
  # CREATE
  get "/guests/new", :controller => "guests", :action => "new"
  post "/create_guest", :controller => "guests", :action => "create"

  # READ
  get "/guests", :controller => "guests", :action => "index"
  #get "/guests/:id", :controller => "guests", :action => "show"

  # UPDATE
  get "/guests/:id/edit", :controller => "guests", :action => "edit"
  post "/update_guest/:id", :controller => "guests", :action => "update"

  # DELETE
  get "/delete_guest/:id", :controller => "guests", :action => "destroy"
  #------------------------------

  # Routes for the Schedule resource:
  # CREATE
  get "/schedules/new", :controller => "schedules", :action => "new"
  post "/create_schedule", :controller => "schedules", :action => "create"

  # READ
  get "/schedules", :controller => "schedules", :action => "index"
  get "/schedules/:id", :controller => "schedules", :action => "show"

  # UPDATE
  get "/schedules/:id/edit", :controller => "schedules", :action => "edit"
  post "/update_schedule/:id", :controller => "schedules", :action => "update"

  # DELETE
  get "/delete_schedule/:id", :controller => "schedules", :action => "destroy"
  #------------------------------
  # Routes for the Home resource:
  # CREATE
  get "/home", :controller => "home", :action => "index"
  post "/home", :controller => "home", :action => "open"
  #------------------------------


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "home#index"
end
