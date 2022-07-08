class InviteMailer < ApplicationMailer
    def new_invite_email
        @project = params[:project]
        @user = params[:user]
        @current_user = params[:current_user]
    
        mail(to: params[:email], subject: "#{@current_user.email} shared project #{@project.project_name} with you")
    end
end
