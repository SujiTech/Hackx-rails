class OrganizationPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def create?
    user.admin?
  end

  def update?
    user.admin? or record.owner == user
  end
end
