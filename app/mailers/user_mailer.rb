class UserMailer < ApplicationMailer

  default from: User.first.email
  default reply_to: User.first.email

  def access_granted(guest, setting)
    @guest = guest
    @setting = setting
    @SORT_ORDER = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    mail(to: @guest.email, subject: 'Access Granted to ' + @setting.title)
  end

  def notify(guest, admin, setting)
    @guest = guest
    @admin = admin
    @setting = setting
    mail(to: @admin.email, subject: 'Attempted Access ' + @setting.title)
  end

end
