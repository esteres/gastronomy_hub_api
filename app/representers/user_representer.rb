class UserRepresenter
  delegate :id, :email, to: :user

  def initialize(user)
    @user = user
  end

  def as_json
    {
      id: id,
      email: email
    }
  end

  private
  
  attr_reader :user
end
