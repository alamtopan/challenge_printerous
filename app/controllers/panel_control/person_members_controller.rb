class PanelControl::PersonMembersController < PanelControl::ApplicationController
  before_action :resource, only: [:edit, :update, :destroy]

  def index
    @person_members = collection.search_by(params).page(page).per(per_page)
  end

  def new
    @person_member = PersonMember.new
  end

  def create
    @person_member = PersonMember.new params_permit
    if @person_member.save
      redirect_to request.referrer, notice: "Successfully created!"
    else
      redirect_to request.referrer, alert: "Unsuccessfully created!"
    end
  end

  def edit
  end

  def update
    if @person_member.update params_permit
      redirect_to request.referrer, notice: "Successfully updated!"
    else
      redirect_to request.referrer, alert: "Unsuccessfully updated!"
    end
  end

  def destroy
    if @person_member.destroy
      redirect_to panel_control_person_members_path, notice: "Successfully deleted!"
    else
      redirect_to panel_control_person_members_path, alert: "Unsuccessfully deleted!"
    end
  end

  private
    def collection
      if current_user.is_admin?
        @person_members = PersonMember.latest
      else
        account_manager = AccountManager.find current_user.id
        organization_ids = account_manager.organizations.pluck(:id)
        @person_members = PersonMember.latest.where(organization_id: organization_ids)
      end
    end

    def resource
      @person_member = PersonMember.find(params[:id])
    end

    def params_permit
      params.require(:person_member).permit(:organization_id, :name, :email, :phone, :avatar)
    end
end