class ReminderMailer < ApplicationMailer
    def new_reminder_email
        @user = params[:user]
        @ticket = params[:ticket]
    
        mail(to: @user.email, subject: "Reminder of #{@ticket.title} deadline")
    end
end
