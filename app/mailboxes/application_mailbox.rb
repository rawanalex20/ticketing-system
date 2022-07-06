class ApplicationMailbox < ActionMailbox::Base
  # http://localhost:3000/rails/conductor/action_mailbox/inboud_emails/new
  # ngrok
  # routing /something/i => :somewhere

  routing SharingMailbox::MATCHER => :sharing
end
