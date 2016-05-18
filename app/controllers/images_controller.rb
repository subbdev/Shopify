class ImagesController < ApplicationController
  before_action :set_image, only: [:show, :edit, :update, :destroy]

  # GET /images
  # GET /images.json
  def index
    @images = Image.all
  end

  # GET /images/1
  # GET /images/1.json
  def show
  end

  # GET /images/new
  def new
    @image = Image.new
  end

  # GET /images/1/edit
  def edit
  end

  # POST /images
  # POST /images.json
  def create
    @product = Product.find(params[:product_id])
    @image = @product.images.create(image_params)

    shop_url = "https://23a2ddfe95ba18463541e8f43fe93cc4:ee0700baa2ac3f34f353fdc58f70e4e7@nishanthstore.myshopify.com/admin"
    ShopifyAPI::Base.site = shop_url

    shop = ShopifyAPI::Shop.current

# Get a specific product
 product = ShopifyAPI::Product.find(6523018883)

# Create a new product
    new_product = ShopifyAPI::Product.new
    new_product.title = "Burton Custom Freestlye 151"
    new_product.product_type = "Snowboard"
    new_product.vendor = "Burton"
    new_product.save

# Update a product
    product.handle = "burton-snowboard"
    product.save

    print "$$$$$$$$$$$$$$$$"

    print Base64.encode64(File.read(@image.attachment.path))
    jdata ={'product'=>{'title'=> @product.title,'body_html'=> @product.body_html,'vendor'=> @product.vendor,'product_type'=> @product.product_type,'published'=> false,'images'=> [{'attachment'=> Base64.encode64(File.read(@image.attachment.path))}]}}.to_json
    print jdata
    res = RestClient.post('https://23a2ddfe95ba18463541e8f43fe93cc4:ee0700baa2ac3f34f353fdc58f70e4e7@nishanthstore.myshopify.com/admin/products.json',jdata,  :content_type => 'application/json',:multipart => true)
    h = JSON.parse(res)
    print '--------'
    respond_to do |format|
      if @image.save
        format.html { redirect_to @product, notice: 'Image was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /images/1
  # PATCH/PUT /images/1.json
  def update
    respond_to do |format|
      if @image.update(image_params)
        format.html { redirect_to @image, notice: 'Image was successfully updated.' }
        format.json { render :show, status: :ok, location: @image }
      else
        format.html { render :edit }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /images/1
  # DELETE /images/1.json
  def destroy
    @image.destroy
    respond_to do |format|
      format.html { redirect_to images_url, notice: 'Image was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_image
      @image = Image.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def image_params
      params.require(:image).permit(:attachment, :product_id)
    end
end
