require 'rails_helper'

RSpec.describe "Projects", type: :request do
    before :each do
        @user = User.create(email: "user@gmail.com", password: "password", password_confirmation: "password")
        sign_in @user
    end
    describe "GET index" do
        it "has a 200 status code" do
          get '/projects'
          expect(response.status).to eq(200)
        end
    end
end
