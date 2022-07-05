class SharingMailbox < ApplicationMailbox
  skip_before_action :verify_authenticity_token
  before_processing :find_user
  MATCHER = /reply-(.+)@reply.example.com/i 
  # mail => Mail object
   # inbound_emails => ActionMailbox::InboundEmail record
  
   # before_processing :ensure_user

   def process
    return if user.nil?
  end

  def user
    @user ||= User.find_by(email: mail.from)
  end

  def ensure_user
    if user.nil?
      bounce_with UserMailer.missing(inbound_email)
    end
  end

  private

  def find_user
    @user = User.find_by(email: mail.from)
  end
  # recipient = mail.recipients.find{ |r| MATCHER.match?(r)}
  # recipient[MATCHER, 1] to run matcher against and the first capture group
end
