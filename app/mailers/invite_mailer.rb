class InviteMailer < ApplicationMailer
    def new_invite_email
        @project = params[:project]
        @user = params[:user]
    
        mail(to: params[:email], subject: "#{@user.email} shared project #{@project.project_name} with you")
    end
end
