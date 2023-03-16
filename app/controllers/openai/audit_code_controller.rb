# frozen_string_literal: true

module Openai
  class AuditCodeController < ApplicationController
    before_action :authenticate_user!
    before_action :check_openai_key, only: :index

    rescue_from StandardError, with: :handle_openai_error

    def create
      @response = ::Openai::AiCodeAudit.new(current_user.open_ai_key, params[:content]).run
      if @response['error'].present?
        flash[:danger] = "We're sorry, but there was a problem with the server. Please try again later."
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
  end
end