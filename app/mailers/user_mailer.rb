class UserMailer < ApplicationMailer
  default from: 'cmoulder1@gmail.com'

  def access_granted(guest, setting)
    @guest = guest
    @setting = setting
    mail(to: @guest.email, subject: 'Access Granted to ' + @setting.title)
  end

end
