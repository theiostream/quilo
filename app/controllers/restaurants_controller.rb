class RestaurantsController < ApplicationController
  protect_from_forgery with: :null_session

  def create
    password = File.read(Rails.root.join('config', 'bozopassword.txt')).strip
    
    if params[:sekrit] != password
      render status: :unauthorized, plain: ''
      return
    end

    @restaurant = Restaurant.new(restaurant_params)
    @restaurant.save

    render json: @restaurant
  end

  def update
    @password = File.read(Rails.root.join('config', 'bozopassword.txt')).strip
    if params[:sekrit] != @password
      render status: :unauthorized, plain: ''
      return
    end
    
    @restaurant = Restaurant.find(params[:id])
    if @restaurant.update(params)
      render json: @restaurant
    else
      render status: :bad_request
    end
  end

  private
  def restaurant_params 
    params.permit(:name, :maps_id)
  end
end
