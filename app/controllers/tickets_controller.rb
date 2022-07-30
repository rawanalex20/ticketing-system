class TicketsController < ApplicationController
  before_action :set_ticket, only: %i[ show edit update destroy save_attach attach change_status ]

  # All routes are preceeded with project
  # GET /tickets
  def index
    @tickets = current_user.shared_projects.find(params[:project_id]).tickets
    @project = current_user.shared_projects.find(params[:project_id])
  end

  # POST /ticket/1/change_status
  def change_status
    # change
    @ticket.status = params[:status]
    @ticket.save
    
    # redirect
    redirect_to project_tickets_url

  end

  # POST /ticket/1/due
  def due_date
  end

  # GET /ticket/1/due
  def due
    
    respond_to do |format|
      @ticket = Ticket.find(params[:id])
      @ticket.due = params[:due]
      @ticket.due_set = true

      if @ticket.save
        # To determine no. of days
        # Assuming due won't last more than a year
        days = @ticket.due.yday - Date.today.yday

        # Works better on production as it is always 
        # active and jobs will stay active till delivery
        SendReminderJob.set(wait: days.day).perform_later(@ticket)

        format.html { redirect_to project_tickets_url, notice: "Due date is successfully set." }
      else
        format.html { redirect_to project_tickets_url, notice: "Something went wrong." }
      end
    end
  end

  # GET /tickets/1
  def show
  end

  # GET /tickets/new
  def new
    @ticket = Ticket.new
    @ticket.project = Project.find(params[:project_id])
  end

  # GET /tickets/1/edit
  def edit
  end

  # POST /tickets
  def create
    @ticket = Ticket.new(ticket_params)
    @ticket.project_id = params[:project_id]

    respond_to do |format|
      if @ticket.save
        format.html { redirect_to project_tickets_url(project_id: @ticket.project.id, id: @ticket.id), notice: "Ticket was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tickets/1
  def update
    respond_to do |format|
      if @ticket.update(ticket_params)
        format.html { redirect_to project_ticket_url(project_id: @ticket.project.id, id: @ticket.id), notice: "Ticket was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tickets/1
  def destroy
    @ticket.destroy

    respond_to do |format|
      format.html { redirect_to project_tickets_url, notice: "Ticket was successfully deleted." }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ticket
      @project = current_user.shared_projects.find(params[:project_id])
      @ticket = @project.tickets.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def ticket_params
      params.require(:ticket).permit(:title, :description, :status, :project_id, :due, uploads: [])
    end
end
