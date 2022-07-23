class OrganisationsController < ApplicationController
  before_action :check_log_in, :set_organisation, only: %i[show update destroy]

  def index
    organisations = Organisation.all

    my_org_users = OrganisationUser.where('user_id = ?', current_user.id)
    @my_orgs = my_org_users.map(&:organisation)

    @not_my_orgs = organisations.reject do |o|
      @my_orgs.include? o
    end
    # raise

    @organisation = Organisation.new
  end

  def show
    @all_org_users = OrganisationUser.where('organisation_id = ?', params[:id])
    @shifts = @all_org_users.map do |u|
      u.shifts
    end.flatten
    @shift = Shift.new

    @me = @all_org_users.find { |organisation_user| organisation_user.user == current_user }

  end

  def new
    @organisation = Organisation.new
  end

  def create
    organisation = Organisation.new(organisation_params)
    if organisation.save
      OrganisationUser.create(
        user_id: current_user.id,
        organisation_id: organisation.id
      )
      redirect_to join_organisation_user_path(organisation)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @organisation.update(organisation_params)
    redirect_to organisations_path
  end

  def destroy
    @organisation.destroy
    redirect_to organisations_path, status: :see_other
  end

  private

  def organisation_params
    params.require(:organisation).permit(:name, :hourly_rate)
  end

  def set_organisation
    @organisation = Organisation.find(params[:id])
  end

  def check_log_in
    return if user_signed_in?

    redirect_to new_user_session_url
  end

end
