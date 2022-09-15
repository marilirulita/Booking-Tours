class ToursController < ApplicationController
  before_action :set_tour, only: %i[show destroy]

  # GET /tours
  def index
    @tours = Tour.all

    render json: @tours
  end

  # GET /tours/1
  def show
    render json: @tour
  end

  # POST /tours
  def create
    @tour = Tour.new(tour_params) # current_user.tours.new(tour_params)

    if @tour.save
      render json: @tour, status: :created, location: @tour
    else
      render json: @tour.errors, status: :unprocessable_entity
    end
  end

  # DELETE /tours/1
  def destroy
    @tour.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_tour
    @tour = Tour.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def tour_params
    params.require(:tour).permit(:title, :description, :cost, :duration, :photo, :city)
  end
end
