# frozen_string_literal: true

module Git
  class IssuesController < ApplicationController
    before_action :authenticate_user!
    before_action :check_git_token
    before_action :set_params

    def new
    end

    def create
      @response = ::Git::Issue.new(current_user.git_token, @git_username, @repo_name).run(@title, @description)
      if @response && @response.is_a?(Hash) && @response['message'].present?
        flash[:danger] = @response['message']
        redirect_to root_path
      else
        flash[:success] = 'Issue created on github successfully'
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
      @title = permitted_params[:title]
      @description = permitted_params[:description]
    end
  end
end
