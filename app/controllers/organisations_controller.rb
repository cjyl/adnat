class OrganisationsController < ApplicationController
  before_action :check_log_in

  def index
    my_org_users = OrganisationUser.where('user_id = ?', current_user.id)
    organisations = Organisation.all
    @my_orgs = my_org_users.map do |og|
      og.organisation
    end
    @not_my_orgs = organisations.reject do |o|
      @my_orgs.include? o
    end
    # raise
  end

  def show

  end

  def create
    @organisation = Organisation.new(organisation_params)
    @organisation.save
    # No need for app/views/organisations/create.html.erb
    redirect_to organisation_path(@organisation)
  end

  def destroy
    @organisation.destroy
    redirect_to organisations_path, status: :see_other
  end

  private

  def organisation_params
    params.require(:organisation).permit(:name, :hourly_rate)
  end

  def check_log_in
    return if user_signed_in?

    redirect_to new_user_session_url
  end

end
