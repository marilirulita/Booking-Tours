class UserToursController < ApplicationController
  # GET /user_tours
  def index
    @reservations = @current_user.user_tours
    @result = []
    @reservations.each do |reserved|
      @result << { tour: Tour.find(reserved.tour_id), persons_number: reserved.persons_number,
                   reservation_date: reserved.reservation_date, reservation_id: reserved.id }
    end
    render json: @result
  end

  # GET /user_tours/1
  def show
    # @user_tour = UserTour.find(params[:id])
    @tour = Tour.find(params[:id])
    render json: @tour
  end

  # POST /user_tours
  def create
    @user_tour = @current_user.user_tours.new(user_tour_params)

    if @user_tour.save
      render json: @user_tour, status: :created, location: @user_tour
    else
      render json: @user_tour.errors, status: :unprocessable_entity
    end
  end

  # DELETE /user_tours/1
  def destroy
    # @user_tour = UserTour.find(params[:id])
    @current_user.user_tours.find(params[:id]).destroy
    # @user_tour.destroy
  end

  private

  # Only allow a list of trusted parameters through.
  def user_tour_params
    params.require(:user_tour).permit(:tour_id, :persons_number, :reservation_date)
  end
end
