require 'date'

class ProgramsController < ApplicationController
  def index
    session[:message] = nil

    selected_prefecture_code = 14
    today = Date.today.strftime('%Y%m%d')

    @stations = Array.new
    AvailableStation.where(prefecture_code: selected_prefecture_code).each do |relation|
      grouped = relation.station.programs.group_by{|prog| prog.start_time.strftime('%H')}
      @stations.push(RadioStation.new(relation.station.name, grouped))
    end
    @hours = ['05', '06', '07', '08', '09', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '20',
      '21', '22', '23', '00', '01', '02', '03', '04']
  end

  def show
    @program = Program.find(params[:id])
    @message = Message.new(session[:message])
  end
end

class RadioStation
  attr_accessor :name
  attr_accessor :progHash

  def initialize(name, progHash)
    @name = name
    @progHash = progHash
  end

end