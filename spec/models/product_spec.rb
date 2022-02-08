require 'rails_helper'

RSpec.describe Product, type: :model do

  before(:each) do
    @product = Product.new
    @category = Category.new name: 'Funiture'
  end

  it 'saves only if all fields are filled' do
    @product_completed = Product.new(name: 'Sofa', price: 120, quantity: 1, category: @category)
    @product_completed.save!
    expect(@product_completed.valid?).to be true
  end

  it 'is invalid without a name' do
    expect(@product).to_not be_valid
    expect(@product.errors.messages[:name]).to include('can\'t be blank')
  end

  it 'is invalid without a price' do
    expect(@product).to_not be_valid
    expect(@product.errors.messages[:price]).to include('can\'t be blank')
  end

  it 'is invalid without a quantity' do
    expect(@product).to_not be_valid
    expect(@product.errors.messages[:quantity]).to include('can\'t be blank')
  end

  it 'invalid without a category' do
    expect(@product).to_not be_valid
    expect(@product.errors.messages[:category]).to include("can\'t be blank")
  end
  
end