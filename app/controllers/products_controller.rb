class ProductsController < ApplicationController
  allow_unauthenticated_access only: [ :index, :show ]
  before_action :set_product, only: [ :show, :edit, :update, :destroy ]

  def index
    @products = Product.all.order(id: :asc)
    if authenticated?
      @user_name = current_user.email_address.split("@").first.capitalize
    end
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      redirect_to root_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy
    redirect_to products_path
  end


  private
    def set_product
      @product = Product.find(params[:id])
    end


    def product_params
      params.require(:product).permit(:name, :description, :price, :user_id, :featured_image)
    end
end
