# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# ★rake db:seed
# rails console ★reload!

kanagawa = Prefecture.create(code: 14, name: '神奈川県')
tbs = Station.create(code: 'TBS', name: 'TBSラジオ')

kanagawa_station = AvailableStation.create(prefecture_code: 14, station_code: 'TBS')

tbs_program = Program.create(title: 'test', start_time: Time.now, end_time: Time.now,
     information: 'test test test', url: 'http://www.yahoo.co.jp', image: 'http://www.yahoo.co.jp',
     performers: 'aaaaaaaaaa', station_code: 'TBS')

tbs_message = Message.create(name: 'mr.a', content: 'bbb', delete_password: 'hogehoge', program_id: 1)