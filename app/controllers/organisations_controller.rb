class OrganisationsController < ApplicationController
  def index
    @organisations = Organisation.all
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

end
