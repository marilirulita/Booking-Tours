class UserToursController < ApplicationController
  before_action :set_user_tour, only: %i[ show destroy ]

  # GET /user_tours
  def index
    @user_tours = UserTour.all # current_user.user_tours.all

    render json: @user_tours
  end

  # GET /user_tours/1
  def show
    render json: @user_tour
  end

  # POST /user_tours
  def create
    @user_tour = UserTour.new(user_tour_params) # current_user.user_tours.new(user_tour_params)

    if @user_tour.save
      render json: @user_tour, status: :created, location: @user_tour
    else
      render json: @user_tour.errors, status: :unprocessable_entity
    end
  end

  # DELETE /user_tours/1
  def destroy
    @user_tour.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_tour
      @user_tour = UserTour.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_tour_params
      params.require(:user_tour).permit(:user_id, :tour_id, :persons_number, :reservation_date)
    end
end
