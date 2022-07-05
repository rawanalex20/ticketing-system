class ProjectsController < ApplicationController
  before_action :set_project, only: %i[ show edit update destroy ]

  # Shared projects
  # GET /projects
  def index
    @@projects = current_user.shared_projects
  end

  # GET /projects/1 or /projects/1.json
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
  end

  # POST /projects/1/invite_form
  def invite_form
    respond_to do |format|
      # Get user by email
      user = User.where(email: params[:email]).first

      # If exists check if it is not the same user
      unless user == nil
        unless user == current_user
          # Get project to share and email to send to
          project = Project.find(params[:project_id])
          email = params[:email]

          # Check if it is not already shared with this user
          unless project.editors.include?(user)

            # Perform invitation job
            SendInviteJob.perform_now(project, email, user)

            # Add user to editors of project so he can access it
            project.editors.append(user)

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

  # POST /projects or /projects.json
  def create
    @project = Project.new(project_params)
    @project.user_id = current_user.id

    respond_to do |format|
      if @project.save
        format.html { redirect_to projects_url, notice: "Project was successfully created." }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1 or /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to projects_url, notice: "Project was successfully updated." }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1 or /projects/1.json
  def destroy
    @project.destroy

    respond_to do |format|
      format.html { redirect_to projects_url, notice: "Project was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def project_params
      params.require(:project).permit(:project_name, :email)
    end
end
