class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy, :update_inventory]

  # GET /products
  # GET /products.json
  def index
    @products = Product.all
  end

  # GET /products/1
  # GET /products/1.json
  def show
  end

  # GET /products/new
  def new
   	session[:last_page] = request.env['HTTP_REFERER'] || products_url
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  	session[:last_page] = request.env['HTTP_REFERER'] || products_url
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)
    @product.update_inventory
		@products = Product.all
    respond_to do |format|
      if @product.save
        format.html { redirect_to session[:last_page] || products_url, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def ftp
  	session[:last_page] = request.env['HTTP_REFERER'] || products_url
  	Product.to_xlsx
  	redirect_to session[:last_page]
  end
	
  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
  	
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to session[:last_page], notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end
  
 	def update_inventory
 		session[:last_page] = request.env['HTTP_REFERER'] || products_url
		@product.update_inventory
		redirect_to session[:last_page]
	end
	
	def update_all_inventory
 		session[:last_page] = request.env['HTTP_REFERER'] || products_url
		Product.update_inventory 
		redirect_to session[:last_page]
	end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:sku, :wholesale_price, :inventory)
    end
end
