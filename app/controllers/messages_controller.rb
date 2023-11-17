class MessagesController < ApplicationController
    def create
        message = Message.new(message_params)
        if message.save
            session[:message] = nil
            flash[:info] = ["保存しました。"]
            redirect_to "/programs/#{message["program_id"]}"
        else
            # 失敗の場合、ルーティングせず、再描画
            # 変数を用意しておく必要あり
            # URLが変わってしまう
            # @program = Program.find(message["program_id"])
            # @message = message
            # render "programs/show"

            # https://qiita.com/yuyasat/items/49e3296f3c64fccc7811
            session[:message] = message.attributes.slice(*message_params.keys)
            flash[:danger] = message.errors.full_messages
            redirect_to "/programs/#{message["program_id"]}"
        end
    end

    def destroy
        message = Message.find(params[:id])

        pp message
        if message.delete_password == params[:pwd] then
            message.destroy
            puts "destroy"
        else
            puts "wrong password"
        end

        redirect_to "/programs/#{message["program_id"]}"
    end

    def message_params
        params.require(:message).permit(:program_id, :name, :content, :delete_password)
    end
end
