class PricesController < ApplicationController
  protect_from_forgery with: :null_session

  def index
    @prices = Price.all#.group('restaurant_id')
  end

  def create
    @password = File.read(Rails.root.join('config', 'bozopassword.txt')).strip
    if params[:sekrit] != @password
      render status: :unauthorized
      return
    end

    @price = Price.new(price_params)
    @price.save

    render json: @price
  end

  def update
    @password = File.read(Rails.root.join('config', 'bozopassword.txt')).strip
    if params[:sekrit] != @password
      render status: :unauthorized, plain: ''
      return
    end
    
    @price = Price.find(params[:id])
    if @price.update(price_params)
      render json: @price
    else
      render status: :bad_request, plain: ''
    end
  end
  
  private
  def price_params 
    params.permit(:restaurant_id, :weekday, :price)
  end
end
