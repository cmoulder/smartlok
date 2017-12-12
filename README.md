# README

This is a Ruby on Rails based smart lock system designed for a Raspberry Pi, but it can be easily modified with a custom unlock method to work on any rails or door lock setup.

The feature set includes:
* Anti-Brute force (lock after 5 invalid attempts). Unlock button available when logged in
* Email notifications to the admin when a user attempts to entry
* Email notification to new users with their code and entry restrictions
* Geofencing
* Entry scheduling
* Access expiration date
* Entry count limit
* Logging for all attempted entries

After installing, run rails db:seed to load some basic settings. The default login is admin:password

This will be updated eventually. Until then, more info can be found at https://hackaday.io/project/27725-smartlok
