class MachineSetsController < ApplicationController
  before_action :set_machine_set, only: [:show, :edit, :update, :destroy]

  before_action :authenticated_admin?, except: [:index]

  # GET /machine_sets
  # GET /machine_sets.json
  def index
    @machine_sets = MachineSet.all
  end

  # GET /machine_sets/1
  # GET /machine_sets/1.json
  def show
  end

  # GET /machine_sets/new
  def new
    @machine_set = MachineSet.new
    @machine = Machine.new
    @machines = [Machine.new]
    @counter = session[:machine_counter] ? session[:machine_counter] : 0
  end

  # GET /machine_sets/1/edit
  def edit
    @machines = @machine_set.machines
    @counter = session[:machine_counter] ? session[:machine_counter] : 0
    @machine = Machine.new
  end

  # POST /machine_sets
  # POST /machine_sets.json
  def create
    @machine_set = MachineSet.new(machine_set_params)
    respond_to do |format|
      binding.pry
      if @machine_set.save
        machines = []
        params['machine_set']['machines'].keys.each do |key|
          param_holder = params['machine_set']['machines'][key]
          param_holder['machine_set_id'] = @machine_set.id
          machines.push(param_holder)
        end
        if Machine.save_all(machines)
          format.html { redirect_to @machine_set, notice: 'Machine set was successfully created.' }
          format.json { render :show, status: :created, location: @machine_set }
        else
          @machine = Machine.new
          format.html { render :new }
          format.json { render json: @machine_set.errors, status: :unprocessable_entity }
        end
      else
        @machine = Machine.new
        format.html { render :new }
        format.json { render json: @machine_set.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /machine_sets/1
  # PATCH/PUT /machine_sets/1.json
  def update
    respond_to do |format|
      if @machine_set.update(machine_set_params)
        format.html { redirect_to @machine_set, notice: 'Machine set was successfully updated.' }
        format.json { render :show, status: :ok, location: @machine_set }
      else
        format.html { render :edit }
        format.json { render json: @machine_set.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /machine_sets/1
  # DELETE /machine_sets/1.json
  def destroy
    @machine_set.destroy
    respond_to do |format|
      format.html { redirect_to machine_sets_url, notice: 'Machine set was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_machine_set
      @machine_set = MachineSet.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def machine_set_params
      params.require(:machine_set).permit(:title, :description, :price, :quantity, :image_url)
    end
end
