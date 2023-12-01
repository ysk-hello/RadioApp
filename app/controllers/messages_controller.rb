class MessagesController < ApplicationController
    def create
        message = Message.new(message_params)
        
        # バリデーション
        if message.valid?
            # ハッシュ化
            message.delete_password = BCrypt::Password.create(message.delete_password)
            # 保存
            message.save

            session[:message] = nil
            flash[:info] = ["保存しました。"]
        else
            session[:message] = message.attributes.slice(*message_params.keys)
            flash[:danger] = message.errors.full_messages
        end

        redirect_to "/programs/#{message["program_id"]}"
    end

    def destroy
        message = Message.find(params[:messageId])

        # パスワードチェック
        if BCrypt::Password.new(message.delete_password) == params[:password] then
            # 削除
            message.destroy

            flash[:info] = ["削除しました。"]
        else
            flash[:danger] = ["削除できませんでした。パスワードが異なっています。"]
        end

        redirect_to "/programs/#{message["program_id"]}"
    end

    def message_params
        params.require(:message).permit(:program_id, :name, :content, :delete_password)
    end
end
