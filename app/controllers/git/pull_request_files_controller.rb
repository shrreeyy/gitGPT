# frozen_string_literal: true

module Git
  class PullRequestFilesController < ApplicationController
    before_action :authenticate_user!
    before_action :check_git_token, only: :index

    def index
      @responses = ::Git::PullRequestFiles.new(current_user.git_token, permitted_params[:git_username], permitted_params[:repo_name], permitted_params[:number]).run
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
  end
end
