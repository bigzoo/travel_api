class ReviewsController < ApplicationController
  before_action :restrict_access
  include ActionController::HttpAuthentication::Token::ControllerMethods

  def index
    if params[:country] && params[:city]
      # Search using both constraints
    elsif params[:country]
      # Search using only country
      country = params[:country]
      @reviews = Review.country_search(country)
    elsif params[:city]
      # Search using only city
      city = params[:city]
      @reviews = Review.city_search(city)
    else
      @reviews = Review.all.order('rating DESC')
    end

    json_response(@reviews)
  end

  def show
    @review = Review.find(params[:id])
    json_response(@review)
  end

  def create
    @review = Review.create!(review_params)
    json_response(@review, :created)
  end

  def update
    @review = Review.find(params[:id])
    if params[:author_user_name] == @review.author_user_name
      @review.update!(review_params)
      json_response(@review,202)
    else
      render status: 401, json: {
        error: "Incorrect or no author username provided."
      }
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    render status: 200, json: {
       message: "Your review has successfully been deleted."
    }
  end

  def random
    id = Random.new.rand(1..Review.all.count)
    @review = Review.find(id)
    json_response(@review)
  end

  private
  def json_response(object, status = :ok)
    render json: object, status: status
  end

  def review_params
    params.permit(:content, :author_full_name, :author_user_name, :rating, :city, :country, :name)
  end

  # def restrict_access
  #   api_key = ApiKey.find_by_access_token(params[:access_token])
  #   render status: 401, json: {
  #      error: "Invalid or no api-key."
  #   }  unless api_key
  #   # head :unauthorized
  # end

  def restrict_access
    authenticate_or_request_with_http_token do |token, options|
      ApiKey.exists?(access_token: token)
    end
  end
end
