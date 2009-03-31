class ServiceController < ApplicationController
  layout 'standard'
  def list
    @services = Service.find(:all)
  end
  def show
    @service = Service.find(params[:id])
  end
  def new
    @service = Service.new
  end
  def create
    @service = Service.new(params[:service])
    if @service.save
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end
  def edit
   @service = Service.find(params[:id]) 
  end
  def update
    @service = Service.find(params[:id])
    if @service.update_attributes(params[:service])
      redirect_to :action => 'show', :id => @service
    else 
      render :action => 'edit'
    end
  end
  def delete
    Service.find(params[:id]).destroy
    redirect_to :action => 'list'
  end

end
