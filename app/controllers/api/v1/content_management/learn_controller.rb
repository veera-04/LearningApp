class Api::V1::ContentManagement::LearnController < ApplicationController

    before_action :doorkeeper_authorize!
	before_action :validate_user!

    def subjects
        render json: subject_param,each_serializer: SubjectSerializer, status: :ok
    end

    def chapters
        # chapters = ActiveModel::Serializer::ArraySerializer.new(chapter_param, each_serializer: ChapterSerializer).to_json
        # render json: {chapters: chapters},status: :ok
        render json: chapter_param,each_serializer: ChapterSerializer,status: :ok
    end

    def contents
        # contents = ActiveModel::Serializer::ArraySerializer.new(content_param, each_serializer: ContentSerializer).to_json
        # render json: {contents: contents}, status: :ok
        render json: content_param,each_serializer: ContentSerializer,status: :ok
    end

    private

    def subject_param
        Subject.where(board_class_id: params[:id])
    end

    def chapter_param
        Chapter.where(subject_id: params[:id])
    end

    def content_param
        Content.where(chapter_id: params[:id])
    end

end