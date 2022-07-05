# Preview all emails at http://localhost:3000/rails/mailers/invite_mailer
class InviteMailerPreview < ActionMailer::Preview
    def new_invite_email
        @project = Project.last
        user = @project.user
    
        InviteMailer.with(project: @project, email: "test@mail.com", user: user).new_invite_email

    end
end
