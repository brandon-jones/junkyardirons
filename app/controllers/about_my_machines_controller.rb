class AboutMyMachinesController < ApplicationController
  before_action :authenticated_admin?, except: [:show] 
  def update
    @about_my_machines = AboutMyMachines.new
    if @about_my_machines.update(params[:about_my_machines])
    
      @about_my_machines = params[:about_my_machines]
      redirect_to :about_my_machines
    end
  end

  def show
    @about_my_machines = AboutMyMachines.new
  end

  def edit
    @about_my_machines = AboutMyMachines.new
  end

  private

    def about_my_machines_params
      params.require(:about_my_machines).permit(:about_my_machines)
    end

end