class SendReminderJob < ApplicationJob
  queue_as :default

  def perform(ticket)
    # When job starts after the due date if status is not 'done' it will send a reminder
    unless ticket.status == "Done"
      ticket.project.editors.each do |user|
        ReminderMailer.with(user: user, ticket: ticket).new_reminder_email.deliver_now
      end
    end
  end
end
