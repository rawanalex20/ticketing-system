require 'rails_helper'

RSpec.describe User, type: :model do

  it "should create new user" do
    user = User.new(email: "test@email.com", password: "111111", password_confirmation: "111111")
    user.save

    expect(user).to be_valid
  end

  it "should not create new user with invalid email" do
    user = User.new(email: "testemail.com", password: "111111", password_confirmation: "111111")
    user.save

    expect(user).to_not be_valid
  end

  it "should not create new user with no email" do
    user = User.new(password: "111111", password_confirmation: "111111")
    user.save

    expect(user).to_not be_valid
  end

  it "should not create new user with no password" do
    user = User.new(email: "test@email.com")
    user.save

    expect(user).to_not be_valid
  end

  it "should not create new user with short password" do
    user = User.new(email: "test@email.com", password: "111", password_confirmation: "111")
    user.save

    expect(user).to_not be_valid
  end

  it "should not create new user with unmatched password" do
    user = User.new(email: "test@email.com", password: "111111", password_confirmation: "111212")
    user.save

    expect(user).to_not be_valid
  end

  it "should not create new user with taken email" do
    user = User.create(email: "test@email.com", password: "111111", password_confirmation: "111111")  
    user = User.new(email: "test@email.com", password: "111111", password_confirmation: "111111")
    user.save

    expect(user).to_not be_valid
  end

end
