# frozen_string_literal: true

module Git
  class RepositoriesController < ApplicationController
    before_action :authenticate_user!
    before_action :check_git_token, only: :index

    def index
      @responses = ::Git::Repository.new(current_user.git_token).run
      if @responses['message'].present?
        flash[:danger] = @responses['message']
        redirect_to root_path
      end
    rescue StandardError => e
      flash[:danger] = "Git API Error: #{e.message}"
    end

    private

    def check_git_token
      redirect_to root_path, danger: 'Please add your github token' unless current_user.git_token.present?
    end
  end
end
