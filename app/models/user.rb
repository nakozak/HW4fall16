class User < ActiveRecord::Base
        def User::create_user!(user_params)
            user_params[:session_token] = SecureRandom.base64
            User.create!(user_params)
        end
end
