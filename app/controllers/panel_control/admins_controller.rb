class PanelControl::AdminsController < PanelControl::ApplicationController 
  prepend_before_action :draw_password, only: :update
  before_action :resource

  def edit
  end

  def update
    if @admin.update params_permit
      redirect_to request.referrer, notice: "Successfully updated"
    else
      redirect_to request.referrer, alert: "Unsuccessfully updated"
    end
  end

  private
    def resource
      @admin = Admin.find params[:id]
    end

    def params_permit
      params.require(:admin).permit(:email, :password, :password_confirmation)
    end

    def draw_password
      %w(password password_confirmation).each do |attr|
        params[:admin].delete(attr)
      end if params[:admin] && params[:admin][:password].blank?
    end
end
