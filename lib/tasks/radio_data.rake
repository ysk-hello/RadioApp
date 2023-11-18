require 'csv'
require 'open-uri'
require 'kconv'
require 'date'
require 'logger'

namespace :radio_data do
    desc "test"
    task test: :environment do
        logger = Logger.new('log/task.log')
        logger.debug('test')
    end

    desc "初回実行: 都道府県を保存する"
    task save_prefectures: :environment do
        puts Dir.pwd

        CSV.foreach("lib/tasks/data/prefectures.csv") do |row|
            puts row[0] + " " + row[1]
            Prefecture.create(code: row[0], name: row[1])
        end
    end

    desc "初回実行: 放送局を保存する"
    task save_stations: :environment do
        url = "https://radiko.jp/v3/station/region/full.xml"
        xml = URI.open(url).read.toutf8()
        hash = Hash.from_xml(xml)

        hash['region']['stations'].each do |stations|
            puts '----------------'
            stations['station'].each do |station|
                puts station['id']
                puts station['name']

                Station.create(code: station['id'], name: station['name'])
            end
        end
    end

    desc "初回実行: 都道府県と放送局の関係を保存する"
    task save_prefectures_stations: :environment do
        Prefecture.all.each do |pref|
            url = "https://radiko.jp/v3/station/list/JP#{pref.code}.xml"
            xml = URI.open(url).read.toutf8()
            hash = Hash.from_xml(xml)

            hash['stations']['station'].each do |station|
                puts pref['code'].to_s + ' ' + station['id']
                AvailableStation.create!(prefecture_code: pref['code'].to_i, station_code: station['id'])
            end

            # 3秒
            sleep(3)
        end
    end

    desc "★定期実行: 番組を保存する"
    task save_programs: :environment do
        Station.all.each do |station|
            url = "http://radiko.jp/v3/program/station/date/#{Date.today.strftime("%Y%m%d")}/#{station.code}.xml"
            puts url
            xml = URI.open(url).read.toutf8()
            hash = Hash.from_xml(xml)
            
            progs = hash['radiko']['stations']['station']['progs']["prog"]
            progs.each do |prog|
                puts station.name + ' ' + prog['title']
                Program.create!(title: prog['title'], start_time: prog['ft'], end_time: prog['to'],
                    information: prog['info'], url: prog['url'], image: prog['img'],
                    performers: prog['pfm'], station_code: station.code)
            end

            # 3秒
            sleep(3)
        end
    end
end
