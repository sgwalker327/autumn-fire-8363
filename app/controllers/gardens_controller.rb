class GardensController < ApplicationController
  def show
    @garden = Garden.find(params[:id])
    @plants = @garden.unique_long_harvest_plants
  end

  
end