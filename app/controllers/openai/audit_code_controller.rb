#frozen_string_literal: true

module Openai
  class AuditCodeController < ApplicationController
    before_action :authenticate_user!
    before_action :check_openai_key, :set_params
    rescue_from StandardError, with: :handle_openai_error

    def new
      @response = ::Openai::AiCodeAudit.new(current_user.open_ai_key, params[:content]).run
      if @response['error'].present?
        flash[:danger] = "We're sorry, but there was a problem with the server. Please try again later."
        redirect_back(fallback_location: root_path)
      else
        suggested_content_for_pr_file
      end
    end

    private

    def check_openai_key
      redirect_to root_path, danger: 'Please add your OpenAI key.' unless current_user.open_ai_key.present?
    end

    def handle_openai_error(error)
      flash[:danger] = "OpenAI API Error: #{error.message}"
      redirect_back(fallback_location: root_path)
    end

    def set_params
      @git_username = params[:git_username]
      @repo_name = params[:repo_name]
      @pr_number = params[:number]
      @commit_id = params[:commit_id]
      @filename = params[:filename]
    end

    def suggested_content_for_pr_file
      message = @response['choices'].first["message"]
      if message.present?
        @suggested_content = message["content"].gsub("\n", "")
      end
      @suggested_content
    end
  end
end
