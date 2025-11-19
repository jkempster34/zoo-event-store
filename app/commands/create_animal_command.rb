class CreateAnimalCommand < BaseCommand
  def initialize(name, price)
    @name = name
    @price = price
  end

  def call
    @animal = Animal.create!(name: @name, price: @price)
  end
end