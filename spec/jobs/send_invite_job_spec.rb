require 'rails_helper'

RSpec.describe SendInviteJob, type: :job do
  before :each do
    @user = User.create!(email: "test@email.com", password: "111111", password_confirmation: "111111")
    sign_in @user
    @user2 = User.create!(email: "test2@email.com", password: "111111", password_confirmation: "111111")
    @project = Project.create!(project_name: "project name", user_id: @user.id)
  end

  # TODO
  # check deleted undefuned methods issue
  it "should send invitation to user" do
    ActiveJob::Base.queue_adapter = :test
    expect {
      SendInviteJob.perform_later(@project, 'test2@email.com', @user2)
    }.to have_enqueued_job
  end
end
