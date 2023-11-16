class MessagesController < ApplicationController
    def create
        message = Message.new(message_params)
        message.save

        redirect_to "/programs/#{message["program_id"]}"
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
