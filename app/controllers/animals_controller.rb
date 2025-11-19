class AnimalsController < ApplicationController
  def index
    @animals = GetAllAnimalsQuery.new.call
    @pot_balance = GetPotBalanceQuery.new.call
  end

  def new
    @animal = Animal.new
  end

  def create
    CreateAnimalCommand.new(
      animal_params[:name],
      animal_params[:price]
    ).call

    redirect_to animals_path
  end

  def buy
    animal = Animal.find(params[:id])
    Rails.configuration.event_store.publish(
      AnimalBought.new(data: { name: animal.name, price: animal.price }),
      stream_name: "zoo-accountancy"
    )
    redirect_to animals_path
  end

  def sell
    animal = Animal.find(params[:id])
    Rails.configuration.event_store.publish(
      AnimalSold.new(data: { name: animal.name, price: animal.price }),
      stream_name: "zoo-accountancy"
    )
    redirect_to animals_path
  end

  private

  def animal_params
    params.require(:animal).permit(:name, :price)
  end
end
