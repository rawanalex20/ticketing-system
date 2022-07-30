class ProjectsController < ApplicationController
  before_action :set_project, only: %i[ show edit update destroy ]

  # Shared projects
  # GET /projects
  def index
    @tickets = Ticket.joins(:project).where('project.user_id' => current_user.id).last(8).reverse
  end

  # GET /projects/1
  def show
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects/1/invite
  def invite
    @project = current_user.shared_projects.find(params[:project_id])
  end

  # POST /projects/1/invite_form
  def invite_form
    respond_to do |format|
      # Get user by email
      user = User.where(email: params[:email]).first

      # If exists check if it is not the same user
      unless user == nil
        unless user == current_user
          email = params[:email]

          # Check if it is not already shared with this user
          unless @project.editors.include?(user)

            # Perform invitation job
            InviteMailer.with(project: @project, email: email, user: user, current_user: current_user).new_invite_email.deliver_now

            # Add user to editors of project so he can access it
            @project.editors.append(user)

            format.html { redirect_to project_tickets_url, notice: "Invitation was successfully sent." }
          else
            format.html { redirect_to project_tickets_url, notice: "User can already access." }
          end
        else
          format.html { redirect_to project_tickets_url, notice: "Cannot enter your email." }
        end
      else
        format.html { redirect_to project_tickets_url, notice: "Invalid email." }
      end
    end
  end

  # POST /projects
  def create
    @project = Project.new(project_params)
    @project.user_id = current_user.id

    respond_to do |format|
      if @project.save
        format.html { redirect_to projects_url, notice: "Project was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to projects_url, notice: "Project was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  def destroy
    @project.destroy

    respond_to do |format|
      format.html { redirect_to projects_url, notice: "Project was successfully destroyed." }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = current_user.shared_projects.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def project_params
      params.require(:project).permit(:project_name, :email)
    end
end
