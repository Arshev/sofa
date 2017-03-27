class Ability
  include CanCan::Ability

  attr_reader :user

  def initialize(user)
    alias_action :vote_up, :vote_down, to: :vote

    @user = user
    if @user
      user.admin? ? admin_abilities : user_abilities
    else
      guest_abilities
    end
  end

  private

  def admin_abilities
    can :manage, :all
  end

  def user_abilities
    can :create, [Question, Answer, Comment, Attachment]
    can [:me, :list], User
    guest_abilities
    owner_abilities
    voting_abilities
  end

  def owner_abilities
    can [:update, :destroy], [Question, Answer, Comment], user_id: @user.id
    can :destroy, Attachment, attachmentable: { user_id: @user.id }
    can :best, Answer, question: { user_id: @user.id }
    can :set_best, Answer do |answer|
      @user.check_author(answer.question)
    end
  end

  def guest_abilities
    can :read, :all
    cannot :read, User
  end

  def voting_abilities
    can :vote, [Question, Answer] do |votable|
      !@user.check_author(votable)
    end
  end
end