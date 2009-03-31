require 'rubygems'
require 'fastercsv'
require 'ar-extensions'
class ServerController < ApplicationController
layout 'standard'
  def list
    @servers = Server.find(:all)
  end
  def show
    @server = Server.find(params[:id])
    @services = Service.find(:all)
  end
  def new
    @server = Server.new
  end
  def create
    @server = Server.new(params[:server])
    if @server.save
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end
  def edit
   @server = Server.find(params[:id]) 
  end
  def select_period
   @server = Server.find(params[:id])
   @service = Service.find(params[:service_id])
  end
  def update
    @server = Server.find(params[:id])
    if @server.update_attributes(params[:server])
      redirect_to :action => 'show', :id => @server
    else 
      render :action => 'edit'
    end
  end
  def delete
    Server.find(params[:id]).destroy
    redirect_to :action => 'list'
  end

  def line_graph_report

    @server = Server.find(params[:id])
    @service = Service.find(params[:service_id])
  
    year = params[:post]['written_on(1i)']
    month = params[:post]['written_on(2i)']
    day = params[:post]['written_on(3i)']

    @observation_day = (year+'-'+month+'-'+day).to_date

## Using fasterCSV to parse data and then ar-extensions by Zach dennis to import the parsed data to db
  observation_columns = [:server_id,:service_id,:observation_key,:observation_value,:observation_date_time]
  observations = Array.new
  FasterCSV.foreach("#{RAILS_ROOT}/public/#{@server.name}/stats.csv",:col_sep => ",") do |row|
    observations << row
  end
  options = { :validate => false }
  Observation.import observation_columns,observations

#Need to emmpty contents of stats.csv to avoid importing duplicate data on next import
#Dirty huh?  
   f = File.open("#{RAILS_ROOT}/public/#{@server.name}/stats.csv",'w')
  f.close
    
    
    g = Gruff::Line.new()
    g.title = "#{@service.name} variations"
    g.font = File.expand_path('artwork/fonts/Vera.ttf', RAILS_ROOT)
    @components = Observation.find(:all, :conditions => ["service_id = ?", @service.id],:group => "observation_key")
    @data = Observation.find(:all, :conditions => ["DATE_FORMAT(observation_date_time, '%Y-%m-%d') = ? AND server_id = ? AND service_id = ?",
                             @observation_day, @server.id, @service.id], :order => "observation_date_time")
    #create an array of times(exact hour and minute) when reading was done 
    @times = []
    @data.each do |d|
      @times << d.observation_date_time.strftime("%H:%M")
    end

# create a hash from the above array to be used as X-axis labels
    @hash_lables = {}
    @times = @times.uniq
    @label_key = 0
    @times.each{|e|
      @hash_lables.store(@label_key, e)
      @label_key += 1
    }


    temp = []
    @components.each do |c|
     temp << c.observation_key.to_s
    end
  # render :text => @data.to_yaml and return    
    built_array = []
    temp.each do |t|
    @built_array = []
    @data.each do |d|
      @built_array << d.observation_value.to_f if (d.observation_key == t)
    end

    
     g.data(t, @built_array)
    end
    g.labels = @hash_lables
    send_data(g.to_blob,:disposition => 'inline', :type => 'image/png', :filename => "#{@service.name} graph.png")
  end

end
