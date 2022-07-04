require 'rails_helper'

RSpec.describe Ticket, type: :model do
  before :each do
    user = User.create(email: "user@gmail.com", password: "password", password_confirmation: "password")
    @project=Project.create(project_name: "project name", user_id: user.id)
  end

  it 'should create ticket' do
    ticket=Ticket.new(title: "title", description: "description", status: "ToDo", project_id: @project.id)

    expect(ticket).to be_valid
  end

  it 'should not create ticket without title' do
    ticket=Ticket.new(description: "description", status: "ToDo", project_id: @project.id)

    expect(ticket).not_to be_valid
  end

  it 'should not create ticket without description' do
    ticket=Ticket.new(title: "title", status: "ToDo", project_id: @project.id)

    expect(ticket).not_to be_valid
  end

  it 'should not create ticket with invalid status value' do
    ticket=Ticket.new(title: "title", description: "description", status: "status", project_id: @project.id)

    expect(ticket).not_to be_valid
  end

  it 'should not create ticket without status value' do
    ticket=Ticket.new(title: "title", description: "description", project_id: @project.id)

    expect(ticket).not_to be_valid
  end

  it 'should not create ticket without a project' do
    ticket=Ticket.new(title: "title", description: "description", status: "ToDo")

    expect(ticket).not_to be_valid
  end
  
end
