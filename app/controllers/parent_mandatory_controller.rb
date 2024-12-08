class ParentMandatoryController < ApplicationController
  before_action :require_login

  def ignore_check
    render json: { success: true }
  end
end
