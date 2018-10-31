class PanelControl::AccountManagersController < PanelControl::ApplicationController
  prepend_before_action :draw_password, only: :update
  before_action :resource, only: [:edit, :update, :destroy]

  def index
    @account_managers = AccountManager.search_by(params).page(page).per(per_page)
  end

  def new
    @account_manager = AccountManager.new
  end

  def create
    @account_manager = AccountManager.new params_permit
    if @account_manager.save
      redirect_to request.referrer, notice: "Successfully created!"
    else
      redirect_to request.referrer, alert: "Unsuccessfully created!"
    end
  end

  def edit
  end

  def update
    if @account_manager.update params_permit
      redirect_to request.referrer, notice: "Successfully updated!"
    else
      redirect_to request.referrer, alert: "Unsuccessfully updated!"
    end
  end

  def destroy
    if @account_manager.destroy
      redirect_to panel_control_account_managers_path, notice: "Successfully deleted!"
    else
      redirect_to panel_control_account_managers_path, alert: "Unsuccessfully deleted!"
    end
  end

  private
    def resource
      @account_manager = AccountManager.find(params[:id])
    end

    def params_permit
      params.require(:account_manager).permit(:email, :password, :password_confirmation)
    end

    def draw_password
      %w(password password_confirmation).each do |attr|
        params[:account_manager].delete(attr)
      end if params[:account_manager] && params[:account_manager][:password].blank?
    end
end