class OmniAuth::Identity::Mailer < ::ActionMailer::Base
  def confirmation_instructions(user)
    @user = user
    mail(:to => "#{user.full_name} <#{user.email}>", :subject => I18n.t(:"omniauth.identity.registration.subject"))
  end

  def reset_password_instructions(user)
    @user = user
    mail(:to => "#{user.full_name} <#{user.email}>", :subject => I18n.t(:"omniauth.identity.reset_password.subject"))
  end
end