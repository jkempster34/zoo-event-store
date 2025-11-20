class AnimalsController < ApplicationController
  def index
    @animals = GetAllAnimalsQuery.new.call
  end

  def new
    @receive = Receive.new
  end

  def create
    @receive = Receive.new(name: params[:name], species: params[:species], date_received: params[:date_received])

    if @receive.run! == false
      render :new
    end

    redirect_to animals_path
  end

  private

  def animal_params
    params.require(:animal).permit(:name, :species, :date_received)
  end
end
