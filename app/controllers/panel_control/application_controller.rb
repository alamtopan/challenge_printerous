class PanelControl::ApplicationController < ApplicationController
  layout 'backend'

  before_action :authenticate_devise!

  def authenticate_devise!
    unless current_user.present?
      redirect_to root_path, alert: "Can't Access this page"
    end
  end

  def per_page
    params[:per_page] ||= 25
  end

  def page
    params[:page] ||= 1
  end
end