class User
  module OmniauthCallbacks
    extend ActiveSupport::Concern

    module ClassMethods
      Devise.omniauth_providers.each do |provider|
        define_method "find_or_create_for_#{provider}" do |response|
          uid = response['uid'].to_s
          data = response['info']

          if (user = Authorization.find_by(provider: provider, uid: uid).try(:user))
            user
          else
            user = User.new_from_provider_data(provider, uid, data)

            if user.save(validate: false)
              user.authorizations.find_or_create_by(provider: provider, uid: uid)
              return user
            else
              Rails.logger.warn("User.create_from_hash Failed，#{user.errors.inspect}")
              return nil
            end
          end
        end
      end

      def new_from_provider_data(provider, uid, data)
        User.new do |user|
          user.email =
            if data['email'].present? && !User.where(email: data['email']).exists?
              data['email']
            else
              "#{provider}+#{uid}@oauth.hackx.org"
            end

          user.username = data['nickname']
          user.username.gsub!(/[^\w]/, '_')
          if provider == :github
            user.username = data['nickname']
          end

          if user.username.blank?
            user.username = "u#{Time.now.to_i}"
          end

          if User.where(username: user.username).exists?
            user.username = "u#{Time.now.to_i}-github" # TODO: possibly duplicated user login here. What should we do?
          end

          user.password = Devise.friendly_token[0, 20]
        end
      end
    end
  end
end
