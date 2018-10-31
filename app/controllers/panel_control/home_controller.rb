class PanelControl::HomeController < PanelControl::ApplicationController
  def dashboard
    if current_user.is_admin?
      @account_managers_count = AccountManager.count
      @organizations_count = Organization.count
      @persons_count = PersonMember.count
    end
  end
end