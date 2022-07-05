require 'rails_helper'

RSpec.describe SendInviteJob, type: :job do
  before :each do
    @user = User.create!(email: "test@email.com", password: "111111", password_confirmation: "111111")
    sign_in @user
    @user2 = User.create!(email: "test2@email.com", password: "111111", password_confirmation: "111111")
    @project = Project.create!(project_name: "project name", user_id: @user.id)
  end

  # TODO
  # test fails and mehtods undefined
  it "should send invitation to user" do
    visit("/projects/#{@project.id}/tickets")
    click_button("Invite")
    fill_in('email', with: 'test2@email.com')
    click_button("Send invitaion")
    ActiveJob::Base.queue_adapter = :test
    expect {
      SendNotificationsJob.perform_now(@project, 'test2@email.com', @user)
    }.to have_enqueued_job
  end
end
