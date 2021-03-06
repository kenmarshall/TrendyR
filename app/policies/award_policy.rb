class AwardPolicy
  PERMITTED_ATTRIBUTES = %i(title description_text earned_at photo_id)

  attr_reader :user, :award

  def initialize(user, award)
    @user = user
    @award = award
  end

  def index?
    create?
  end

  def new?
    create?
  end

  def create?
    user.roles?(%w(producer label))
  end

  def edit?
    update?
  end

  def update?
    create? && user.profile == award.owner_profile
  end

  def destroy?
    create?
  end

  def permitted_attributes
    PERMITTED_ATTRIBUTES
  end

  def scope
    Pundit.policy_scope!(user, award.class)
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope
    end
  end
end
