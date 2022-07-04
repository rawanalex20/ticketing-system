class TicketsController < ApplicationController
  before_action :set_ticket, only: %i[ show edit update destroy ]

  # # GET /tickets
  # def tickets
  #   projects = current_user.shared_projects
  #   @tickets = []
  #   projects.each do |project|
  #     project.each do |ticket|
  #       @tickets.append(ticket)
  #     end
  #   end
  # end

  # GET /tickets or /tickets.json
  def index
    @tickets = Ticket.where(project_id: params[:project_id])

    if @tickets == nil
      @tickets = []
    end
    @project = Project.find(params[:project_id])
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
    p "PROJECT #{params[:project_id]}"
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
      params.require(:ticket).permit(:title, :description, :status, :project_id)
    end
end
