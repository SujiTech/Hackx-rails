class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def self.provides_callback
    Devise.omniauth_providers.each do |provider|
      class_eval %{
        def #{provider.to_s}
          if not current_user.blank?
            current_user.bind_service(env["omniauth.auth"])#Add an auth to existing
            redirect_to edit_user_registration_path, notice: "Binded #{provider} to Account."
          else
            @user = User.find_or_create_for_#{provider}(env["omniauth.auth"])
            if @user.persisted?
              sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
              set_flash_message(:notice, :success, :kind => "#{provider}") if is_navigational_format?
            else
              session["devise.#{provider}_data"] = request.env["omniauth.auth"]
              redirect_to new_user_registration_url
            end
          end
        end
      }
    end
  end

  provides_callback

  # This is solution for existing accout want bind Google login but current_user is always nil
  # https://github.com/intridea/omniauth/issues/185
  def handle_unverified_request
    true
  end

  def failure
    redirect_to root_path
  end
end
