# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create! :username => 'admin', :email => 'admin@admin.com', :password => 'password', :password_confirmation => 'password'

log = Log.new
log.status = 'Access Granted'
log.name = 'System Config'
log.accesscode = 0000
log.save!

setting = Setting.new
setting.title = 'My Apartment'
setting.radius  = 500.0
setting.lat = 25.1971482
setting.lon = 55.2743221
setting.save!
