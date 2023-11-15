FROM ruby:3.0.4

# railsの前提条件
RUN apt-get update -qq
RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - && apt-get install -y nodejs
RUN apt install -y cron nano systemctl
# npm必要
RUN npm install --global yarn

# ロケール
# RUN locale-gen ja_JP.UTF-8
# RUN localedef -f UTF-8 -i ja_JP ja_JP

# 環境変数
ENV LANG=ja_JP.UTF-8
ENV TZ=Asia/Tokyo

# cron
# TZ変更
# https://qiita.com/jerrywdlee/items/d4468f076bdea236bf3b
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN mkdir /app

WORKDIR /app
COPY . /app

COPY Gemfile Gemfile.lock /app/

# rails install
RUN bundle install

# run
#CMD ["ruby", "rails.rb"]
