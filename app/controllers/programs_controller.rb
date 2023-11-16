require 'date'

class ProgramsController < ApplicationController
  def index
    selected_prefecture_code = 14
    today = Date.today.strftime('%Y%m%d')

    @stations = Array.new
    AvailableStation.where(prefecture_code: selected_prefecture_code).each do |record|
      @stations.push(record.station)
      pp record.station
    end
  end

  def show
    @program = Program.find(params[:id])
  end
end
