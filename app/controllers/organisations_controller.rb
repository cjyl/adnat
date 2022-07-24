class OrganisationsController < ApplicationController
  before_action :set_organisation, only: %i[show update destroy]

  def index
    if user_signed_in?
      organisations = Organisation.all

      my_org_users = OrganisationUser.where('user_id = ?', current_user.id)
      @my_orgs = my_org_users.map(&:organisation)

      @not_my_orgs = organisations.reject do |o|
        @my_orgs.include? o
      end
      # raise

      @organisation = Organisation.new

    else
      redirect_to home_path
    end

  end

  def show
    if user_signed_in?
      @all_org_users = OrganisationUser.where('organisation_id = ?', params[:id])
      @shifts = @all_org_users.map do |u|
        u.shifts
      end.flatten
      @shift = Shift.new
      @me = @all_org_users.find { |organisation_user| organisation_user.user == current_user }
    else
      redirect_to home_path
    end
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
    redirect_to organisation_path(organisation_params)
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
end
  # def check_log_in
  #   return if user_signed_in?

  #   redirect_to home_path
  # end
