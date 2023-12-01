class MessagesController < ApplicationController
    def create
        message = Message.new(message_params)
        
        if message.valid?
            # ハッシュ化
            # https://qiita.com/kobayashimakoto/items/603d6434ba1952dfea69
            message.delete_password = BCrypt::Password.create(message.delete_password)
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

        pp message
        if BCrypt::Password.new(message.delete_password) == params[:password] then
            message.destroy
            puts "destroy"
            flash[:info] = ["削除しました。"]
        else
            puts "wrong password"
            flash[:danger] = ["削除できませんでした。パスワードが異なっています。"]
        end

        redirect_to "/programs/#{message["program_id"]}"
    end

    def message_params
        params.require(:message).permit(:program_id, :name, :content, :delete_password)
    end
end
