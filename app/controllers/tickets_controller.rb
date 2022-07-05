class TicketsController < ApplicationController
  before_action :set_ticket, only: %i[ show edit update destroy save_attach attach ]

  # All routes are preceeded with project
  # GET /tickets or /tickets.json
  def index
    @tickets = Ticket.where(project_id: params[:project_id])

    # Initialize it to array if its nil for looping
    if @tickets == nil
      @tickets = []
    end

    @project = Project.find(params[:project_id])
  end

  # GET /ticket/1/attach
  def attach
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
        # Assuming sue won't last more than a year
        #@ticket.due.strftime("%j")
        days = @ticket.due.yday - Date.today.yday 
        # days = days.to_i % 365
        # Assuming the app is running in production and job 
        # is set to perform on the due date
        p "JJJJJJJ #{days} LLLLLLL"
        SendReminderJob.set(wait: days.day).perform_later(@ticket)

        format.html { redirect_to project_tickets_url, notice: "Due date is successfully set." }
      else
        format.html { redirect_to project_tickets_url, notice: "Something wents wrong." }
      end
    end
  end

  # PATCH /ticket/1/attach
  def save_attach
    @ticket.uploads = params[:uploads]
    respond_to do |format|
      if @ticket.save#update(ticket_params)
        format.html { redirect_to project_ticket_url(project_id: @ticket.project.id, id: @ticket.id), notice: "Ticket was successfully updated." }
        format.json { render :show, status: :ok, location: @ticket }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /tickets/1 or /tickets/1.json
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

  # POST /tickets or /tickets.json
  def create
    @ticket = Ticket.new(ticket_params)
    @ticket.project_id = params[:project_id]

    respond_to do |format|
      if @ticket.save
        format.html { redirect_to project_ticket_url(project_id: @ticket.project.id, id: @ticket.id), notice: "Ticket was successfully created." }
        format.json { render :show, status: :created, location: @ticket }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tickets/1 or /tickets/1.json
  def update
    respond_to do |format|
      if @ticket.update(ticket_params)
        format.html { redirect_to project_ticket_url(project_id: @ticket.project.id, id: @ticket.id), notice: "Ticket was successfully updated." }
        format.json { render :show, status: :ok, location: @ticket }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tickets/1 or /tickets/1.json
  def destroy
    @ticket.destroy

    respond_to do |format|
      format.html { redirect_to project_tickets_url, notice: "Ticket was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ticket
      @ticket = Ticket.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def ticket_params
      params.require(:ticket).permit(:title, :description, :status, :project_id, :due, uploads: [])
    end
end
