class OrganisationUsersController < ApplicationController
  def join
    OrganisationUser.create(
      user_id: current_user.id,
      organisation_id: params[:id]
    )
    redirect_to organisations_path, status: :see_other
  end

  def leave
    organisation = Organisation.find(params[:id])
    my_org_user = OrganisationUser.where('user_id = ? AND organisation_id = ?', current_user.id, organisation.id)
    my_org_user[0].destroy
    redirect_to organisations_path, status: :see_other
  end
end
