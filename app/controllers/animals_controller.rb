class AnimalsController < ApplicationController
  def index
    @animals = GetAllAnimalsQuery.new.call
  end

  def new
    @receive = Receive.new
  end

  def create
    @receive = Receive.new(
      animal_params
    )

    if @receive.run! == false
      render :new && return
    end

    redirect_to animals_path
  end

  private

  def animal_params
    params.require(:receive).permit(
      :name,
      :species,
      :date_received,
      :cites_certificate_present
    )
  end
end
