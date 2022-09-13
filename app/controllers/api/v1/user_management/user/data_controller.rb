class Api::V1::UserManagement::User::DataController < ApplicationController

    before_action :doorkeeper_authorize!
    before_action :validate_user!

    def boards
        render json: Board.all, each_serializer: BoardSerializer, status: :ok
    end

    def board
        if current_user.update(board_id: get_board['board_id'])
            render json: current_user.board,status: :ok
        else
            render json: current_user.errors, status: :unprocessable_entity
        end
    end

    def classes
        render json: class_params ,each_serializer: BoardClassSerializer, status: :ok
    end

    def board_class
        if current_user.update(board_class_id: get_class_id['board_class_id'])
            render json: current_user.board_class, status: :ok
        else
            render json: current_user.errors, status: :unprocessable_entity
        end
    end

    private

    def get_board
        params.require(:student).permit(:board_id)
    end

    def class_params
        BoardClass.where(board_id: params[:id])
    end

    def get_class_id
        params.require(:student).permit(:board_class_id)
    end

end