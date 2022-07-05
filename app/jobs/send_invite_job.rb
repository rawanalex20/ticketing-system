class SendInviteJob < ApplicationJob
  queue_as :default

  def perform(project, email, user)
    InviteMailer.with(project: project, email: email, user: user).new_invite_email.deliver_now
  end
end
