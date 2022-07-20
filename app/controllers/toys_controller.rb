class ToysController < ApplicationController
  wrap_parameters format: []

  def index
    toys = Toy.all
    render json: toys
  end

  def create
    toy = Toy.create!(toy_params)
    render json: toy, status: :created
  rescue ActiveRecord::InvalidRecord => invalid
    render json: { errors: invalid.record.errors }, status: :unprocessable_entity
  end

  def update
    # byebug
    toy = find_toy
    toy.update!(toy_params)
    render json: toy
  end

  def destroy
    toy = Toy.find_by(id: params[:id])
    toy.destroy
    head :no_content
  end

  private
  
  def toy_params
    params.permit(:name, :image, :likes)
  end

  def find_toy
    Toy.find_by(id: params[:id])
  end

end
