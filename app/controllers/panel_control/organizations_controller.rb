class PanelControl::OrganizationsController < PanelControl::ApplicationController
  before_action :resource, only: [:edit, :update, :destroy, :show]

  def index
    @organizations = collection.search_by(params).page(page).per(per_page)
  end

  def show
    @person_members = @organization.person_members.latest.search_by(params).page(page).per(per_page)
  end

  def new
    @organization = Organization.new
  end

  def create
    @organization = Organization.new params_permit
    @organization.account_manager_id = current_user.id if current_user.is_account_manager?
    if @organization.save
      redirect_to request.referrer, notice: "Successfully created!"
    else
      redirect_to request.referrer, alert: "Unsuccessfully created!"
    end
  end

  def edit
  end

  def update
    if @organization.update params_permit
      redirect_to request.referrer, notice: "Successfully updated!"
    else
      redirect_to request.referrer, alert: "Unsuccessfully updated!"
    end
  end

  def destroy
    if @organization.destroy
      redirect_to panel_control_organizations_path, notice: "Successfully deleted!"
    else
      redirect_to panel_control_organizations_path, alert: "Unsuccessfully deleted!"
    end
  end

  private
    def resource
      @organization = Organization.find(params[:id])
    end

    def collection
      if current_user.is_admin?
        @organizations = Organization.latest
      else
        @organizations = Organization.latest.where(account_manager_id: current_user.id)
      end
    end

    def params_permit
      params.require(:organization).permit(:name, :email, :website, :logo, :phone, :account_manager_id)
    end
end