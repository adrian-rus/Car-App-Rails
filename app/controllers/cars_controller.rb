require 'my_logger'
require 'car_decorator'
class CarsController < ApplicationController
  
  # request authentication or registration 
  before_filter :authenticate_user!
  before_filter :ensure_admin, :only => [:edit, :destroy]
  
  #  before_action :set_car, only: [:show, :edit, :update, :destroy]
  
  def ensure_admin
    unless current_user && current_user.admin?
      render :text => "Access Error Message", :status => :unauthorized
    end
  end

  # GET /cars
  # GET /cars.json
  def index
    @cars = Car.all
    
    if params[:search]
      #select all the cars which match the search pattern
      @cars = Car.search(params[:search])
      
      #order the selected rows ascending by created_at field
      @cars = @cars.order("created_at ASC")
    else
      #order all the rows descending by created_at field
      @cars = @cars.order("created_at DESC")
    end
    
  end

  # GET /cars/1
  # GET /cars/1.json
  def show
  end

  # GET /cars/new
  def new
    @car = Car.new
  end

  # GET /cars/1/edit
  def edit
  end

  # POST /cars
  # POST /cars.json
  def create
    @car = Car.new(car_params)
    
    @car = Car.new()
    @car.firstname = params[:car][:firstname]
    @car.lastname = params[:car][:lastname]
    @car.color = params[:car][:color]
    @car.manufacturer = params[:car][:manufacturer]
    # create an instance/object of a BasicCar
    myCar = BasicCar.new(15000, @car.manufacturer, @car.color)
    
    # add the extra features to the new car
    if params[:car][:windows].to_s.length > 0 then
      myCar = ElectricWindowsDecorator.new(myCar)
    end
    
    if params[:car][:mirror].to_s.length > 0 then
      myCar = MirrorDecorator.new(myCar)
    end
    
    if params[:car][:psensor].to_s.length > 0 then
      myCar = ParkingSensorDecorator.new(myCar)
    end
    
    ## populate the cost and the description details
    @car.cost = myCar.cost
    @car.description = myCar.details
    
    #retrieve the instance of MyLogger class
    logger = MyLogger.instance
    logger.logInformation("A new car requested: " + @car.description)

    respond_to do |format|
      if @car.save
        format.html { redirect_to @car, notice: 'Car was successfully created.' }
        format.json { render :show, status: :created, location: @car }
      else
        format.html { render :new }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cars/1
  # PATCH/PUT /cars/1.json
  def update
    
    #update the instance variables with the information 
    # user provided in the form
    # retrieve each value from the params hash
    
    @car.firstname = params[:car][:firstname]
    @car.lastname = params[:car][:lastname]
    @car.color = params[:car][:color]
    @car.manufacturer = params[:car][:manufacturer]
    # create an instance/object of a BasicCar
    # here I hard-code the cost of a car,
    # namely all my basic cars are going to cost 15000
    
    myCar = BasicCar.new(15000, @car.manufacturer, @car.color)
    # add the extra features to the myCar object if the user selected them
    # we use an implementation of the decorator pattern
    # to dynamically provide the extra features to a car
    # each of the check-boxex the user checks is used to
    # decide whether to apply a specific decoration
    
    if params[:car][:windows].to_s.length > 0 then
      myCar = ElectricWindowsDecorator.new(myCar)
    end
    
    if params[:car][:mirror].to_s.length > 0 then
      myCar = MirrorDecorator.new(myCar)
    end
    
    if params[:car][:psensor].to_s.length > 0 then
      myCar = ParkingSensorDecorator.new(myCar)
    end
    
    ## update the cost and the description details
    @car.cost = myCar.cost
    @car.description = myCar.details
    
    # build a hash with the updated information of the car
    updated_information = {
      "firstname" => @car.firstname,
      "lastname" => @car.lastname,
      "manufacturer" => @car.manufacturer,
      "cost" => @car.cost,
      "description" => @car.description,
      "color" => @car.color
    }
    
    respond_to do |format|
      # call the method update() of the ActiveRecord instance
      # to update the car with the new information
      # note that the method update() of the ActiveRecord receives
      # the hash we created above
      if @car.update(updated_information)
        format.html { redirect_to @car, notice: 'Car was successfully updated.' }
        format.json { render :show, status: :ok, location: @car }
      else
        format.html { render :edit }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cars/1
  # DELETE /cars/1.json
  def destroy
    @car.destroy
    respond_to do |format|
      format.html { redirect_to cars_url, notice: 'Car was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_car
      @car = Car.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def car_params
      params.require(:car).permit(:firstname, :lastname, :manufacturer, :cost, :description, :color)
    end
end
