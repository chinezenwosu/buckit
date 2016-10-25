class UsersController < ApplicationController
  include Messages
  include Sessions

  def create
    user = User.new(user_params)
    if user.save
      flash_and_redirect_to_root(:success, successful_signup_message)
    else
      render(json: { error: user.errors.full_messages })
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :email,
      :password,
      :password_confirmation
    )
  end
end
