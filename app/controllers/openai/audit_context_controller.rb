#frozen_string_literal: true

module Openai
  class AuditContextController < ApplicationController
    before_action :authenticate_user!
    before_action :check_openai_key, :set_params, :check_content
    rescue_from StandardError, with: :handle_openai_error

    def new
      @response = ::Openai::AiCodeAudit.new(current_user.open_ai_key, params[:content]).run
      if @response['error'].present?
        flash[:danger] = "We're sorry, but there was a problem with the server. Please try again later."
        redirect_back(fallback_location: root_path)
      else
        set_title_description_for_github_issue
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
    end

    def set_title_description_for_github_issue
      content_hash = response_hash
      if content_hash.present?
        @title = content_hash[:title]
        @description = content_hash[:description]
      else
        flash[:danger] = 'Failed to parse title and description from OpenAI response'
        redirect_to new_issue_path(git_username: @git_username, repo_name: @repo_name)
      end
    end

    def response_hash
      content_hash = {}
      message = @response['choices'].first["message"]
      if message.present? && message["content"].to_s.match?(/Title:.*Description:/m)
        content = message["content"].gsub("\n", "").split(/Title:|Description:/)
        content_hash = {
          title: content[1].strip,
          description: content[2].strip
        }
      end
      content_hash
    end

    def check_content
      return if params[:content].to_s.downcase.include?('title') && params[:content].to_s.downcase.include?('description')

      flash[:danger] = 'Please provide proper context as displayed below'
      redirect_to new_issue_path(git_username: @git_username, repo_name: @repo_name)
    end
  end
end
