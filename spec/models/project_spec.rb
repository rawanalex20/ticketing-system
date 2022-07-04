require 'rails_helper'

RSpec.describe Project, type: :model do

  before :each do
    @user = User.create(email: "user@gmail.com", password: "password", password_confirmation: "password")
  end

  it 'should create project' do
    project=Project.create(project_name: "project name", user_id: @user.id)

    expect(project).to be_valid
  end

  it 'should not create project as name required' do
    project=Project.create(project_name: "", user_id: @user.id)

    expect(project).to_not be_valid
  end

  context 'Sharing project' do
    before :each do
      @project=Project.create(project_name: "project name", user_id: @user.id)
      @user2 = User.create(email: "user2@gmail.com", password: "password", password_confirmation: "password")
    end 

    it 'should add editor' do
      @project.editors.append(@user2)

      expect(@project.editors.last.id).to be @user2.id
    end

  end
end
