class ParksController < ApplicationController
  def index
    @city = City.find(params[:city_id])
    @parks = Park.where(city: @city)
  end

  def show
    @city = City.find(params[:city_id])
    @park = Park.find(params[:id])
  end

  def new
    @city = City.find(params[:city_id])
    @park = Park.new
  end

  def edit
    @city = City.find(params[:city_id])
    @park = Park.find(params[:id])
  end

  def create
    @city = City.find(params[:city_id])
    @park = @city.parks.new(park_params)
    @park.creator = current_user
    if @park.save
      redirect_to city_park_path(@city, @park)
    else
      @errors = @park.errors.full_messages
      render 'new'
    end
  end

  def update
    @city = City.find(params[:city_id])
    @park = Park.find(params[:id])

    if @park.update(park_params)
      redirect_to city_park_path(@city, @park)
    else
      @errors = @park.errors.full_messages
      render 'edit'
    end
  end

  private

  def park_params
    params.require(:park).permit(:name, :description, :city, :creator)
  end
end
