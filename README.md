# Radibo(ラジボ)
ラジオ番組掲示板

## 環境
* Ubuntu: 22.04.2 LTS
* Ruby: 3.0.4
* MySQL: 8.0.35
* rails: 6.1.0
* bcrypt
* whenever
* rinku

## 環境構築
### インストール
プロジェクトのgemをインストールする。
```
bundle install
```
### データベース準備
#### 接続設定
データベースの接続設定を行う。
```
/config/database.yml
```
#### データベース作成
データベース、テーブルを作成する。
```
rails db:create
rails db:migrate
```
#### タスク実行
タスクを実行し、初期データを保存する。
```
rails radio_data:save_prefectures
rails radio_data:save_stations
rails radio_data:save_prefectures_stations
```
### 定期タスク設定
定期タスクをwheneverでcronに設定する。
```
whenever --update-crontab
```

## 実行
```
rails s -b 0.0.0.0
```

## 補足: 主なファイル
| 種類 | 場所 |
| - | - |
| Model | /app/models |
| View | /app/views |
| Controller | /app/controllers |
| Migration | /db/migrate |
| Task | /lib/tasks |
| Routing | /config/routes.rb |
| Docker | /docker |
