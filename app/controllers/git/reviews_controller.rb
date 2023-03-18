# frozen_string_literal: true

module Git
  class ReviewsController < ApplicationController
    before_action :authenticate_user!
    before_action :check_git_token
    before_action :set_params

    def create
      @response = ::Git::Review.new(current_user.git_token, @git_username, @repo_name, @number).run(@content, @commit_id, @path)
      if @response['message'].present?
        flash[:danger] = @response['message']
        redirect_back(fallback_location: root_path)
      else
        flash[:success] = 'Review Added successfully'
        redirect_to repositories_path
      end
    rescue StandardError => e
      flash[:danger] = "Git API Error: #{e.message}"
    end

    private

    def check_git_token
      redirect_to root_path, danger: 'Please add your github token' unless current_user.git_token.present?
    end

    def permitted_params
      params.permit!
    end

    def set_params
      @git_username = permitted_params[:git_username]
      @repo_name = permitted_params[:repo_name]
      @number = permitted_params[:number]
      @content = permitted_params[:content]
      @commit_id = permitted_params[:commit_id]
      @path = permitted_params[:path]
    end
  end
end
