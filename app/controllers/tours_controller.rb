class ToursController < ApplicationController
  skip_before_action :authenticate_request, only: %i[index show]
  # GET /tours
  def index
    @tours = Tour.all

    render json: @tours
  end

  # GET /tours/1
  def show
    @tour = Tour.find(params[:id])
    render json: @tour
  end

  # POST /tours
  def create
    @tour = @current_user.tours.new(tour_params)

    if @tour.save
      render json: @tour, status: :created, location: @tour
    else
      render json: @tour.errors, status: :unprocessable_entity
    end
  end

  # DELETE /tours/1
  def destroy
    @current_user.tours.find(params[:id]).destroy
  end

  private

  # Only allow a list of trusted parameters through.
  def tour_params
    params.require(:tour).permit(:title, :description, :cost, :duration, :photo, :city)
  end
end
