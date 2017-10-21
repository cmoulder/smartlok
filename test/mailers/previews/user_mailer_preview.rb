# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def access_granted
    UserMailer.access_granted(Guest.first, Setting.first)
  end
end
