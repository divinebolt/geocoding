class DishesController < ApplicationController
  before_action :set_dish, only: %i[ show edit update destroy ]

  # GET /dishes or /dishes.json
  def index
    @dishes = Dish.all

    # the `geocoded` scope filters only flats with coordinates (latitude & longitude)
    @markers = @dishes.geocoded.map do |dish|
    {
      lat: dish.latitude,
      lng: dish.longitude,
      info_window: render_to_string(partial: "info_window", locals: { dish: dish }),
      image_url: helpers.asset_url("green_marker")
    }
    end
  end

  # GET /dishes/1 or /dishes/1.json
  def show
  end

  # GET /dishes/new
  def new
    @dish = Dish.new
  end

  # GET /dishes/1/edit
  def edit
  end

  # POST /dishes or /dishes.json
  def create
    @dish = Dish.new(dish_params)

    respond_to do |format|
      if @dish.save
        format.html { redirect_to dish_url(@dish), notice: "Dish was successfully created." }
        format.json { render :show, status: :created, location: @dish }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @dish.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dishes/1 or /dishes/1.json
  def update
    respond_to do |format|
      if @dish.update(dish_params)
        format.html { redirect_to dish_url(@dish), notice: "Dish was successfully updated." }
        format.json { render :show, status: :ok, location: @dish }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @dish.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dishes/1 or /dishes/1.json
  def destroy
    @dish.destroy

    respond_to do |format|
      format.html { redirect_to dishes_url, notice: "Dish was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dish
      @dish = Dish.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def dish_params
      params.require(:dish).permit(:name, :address)
    end
end
