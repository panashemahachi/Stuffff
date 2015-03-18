class Mailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.mailer.invitation.subject
  #
  def invitation(invitation, signup_url)
    #@greeting = "Hi"

    #mail to: "to@example.org"

    subject 'Stuffff Invitation'
    recipients invitation.recipient_email
    from 'invite@stuffff.me'
    body :invitation => 'You are invited to join Stuffff! #{signup_url}'
    invitation.update_attribute(:sent_at, Time.now)
  end
end
