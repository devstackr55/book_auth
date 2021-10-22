class Api::V1::Users::SessionsController < Api::V1::BaseController
  include JwtAuthenticator

  def create
    user = User.find_by(email: params[:email])
    if user&.valid_password?(params[:password])
      sign_me_in(user)
      render json: { message: 'Signed in successfully.' }
    else
      render json: { errors: 'Invalid credentials!' }, status: :unauthorized
    end
  end
end
