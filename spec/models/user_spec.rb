require 'rails_helper'

RSpec.describe User, type: :model do

  before (:each) do
    @user = User.new(first_name: 'Sonia', last_name: 'Fox', email: 'sonia@gmail.com', password: '123456', password_confirmation: '123456')
  end

  describe 'Validations' do

    it 'saves user only if all fields are filled' do
      @user.save
      expect(@user).to be_valid 
    end

    it 'is invalid without a first_name' do
      @user.first_name = nil
      # @user = User.new(first_name: nil, last_name: 'Fox', email: 'sonia@gmail.com', password: '123456', password_confirmation: '123456')
      @user.save
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end
    
    it 'is invalid without a last_name' do
      @user.last_name = nil
      @user.save
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include('Last name can\'t be blank')
    end

    it 'is invalid without email' do
      @user.email = nil
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include('Email can\'t be blank')
    end

    it 'is invalid without password' do
      @user.password = nil
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include('Password can\'t be blank')
    end

    it 'is invalid without password confirmation' do
      @user.password_confirmation = nil
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Password confirmation can't be blank")
    end  

    it 'chacks password minimum length 6 characters' do
      @user.password = '12345'
      @user.save
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
    end

    it "chacks password confirmation doesn't match Password" do
      @user.password = '123456'
      @user.password_confirmation = '654321'
      @user.save
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'validates uniqueness of email' do
      @user1 = User.new(first_name: 'Sonia', last_name: 'Fox', email: 'sonia@gmail.com', password: '123456', password_confirmation: '123456')
      @user2 = User.new(first_name: 'Sonia', last_name: 'Fox', email: 'sonia@gmail.com', password: '123456', password_confirmation: '123456')
      @user1.save
      @user2.save
      expect(@user1).to be_valid
      expect(@user2).to_not be_valid
      expect(@user2.errors.full_messages).to include("Email has already been taken")
    end

  describe '.authenticate_with_credentials' do
    # examples for this class method here
  end
end 
end