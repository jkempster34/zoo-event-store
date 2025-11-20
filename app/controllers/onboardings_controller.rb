require 'pry'

class OnboardingsController < ApplicationController
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

    redirect_to onboarding_path(@receive.onboarding_id)
  end

  def show
    @onboarding = Onboarding.find_by!(unique_id: params[:id])
    @start_quarantine = StartQuarantine.new(onboarding_id: @onboarding.unique_id)
  end

  def start_quarantine
    binding.pry
    @start_quarantine = StartQuarantine.new(
      quarantine_params
    )


    if @start_quarantine.run! == false

      render :new && return
    end

    redirect_to onboarding_path(@start_quarantine.onboarding_id)
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

  def quarantine_params
    params.require(:start_quarantine).permit(
      :quarantine_started_at,
      :quarantine_location
    ).merge(onboarding_id: params[:id])
  end
end
