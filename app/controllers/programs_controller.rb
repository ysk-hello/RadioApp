require 'date'

class ProgramsController < ApplicationController
  def index
    @selected_prefecture_code = 14
    if request.post?
      @selected_prefecture_code = params[:prefecture]
    end
    session[:message] = nil

    @prefectures = Prefecture.pluck(:name, :code)

    @today = Date.today
    now = DateTime.now
    if now.hour >= 0 && now.hour < 5
      # 5時切り替え
      @today = @today.prev_day(1)
    end

    @stations = Array.new
    AvailableStation.where(prefecture_code: @selected_prefecture_code).each do |relation|
      grouped = relation.station.programs.where(created_at: @today.all_day).group_by{|prog| prog.start_time.strftime('%H')}
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