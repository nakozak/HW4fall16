class SessionsController < ApplicationController
   
    def session_params
        params.require(:user).permit(:user_id, :email, :session_token)
    end
    
    def new
    end
    
    def create
        if(User.exists?(:user_id=> session_params[:user_id]) && User.exists?(:email => session_params[:email]))
            flash[:notice] = "You are logged in as #{session_params[:user_id]}"
            @user = User.find_by(session_params)
            @email = User.find_by(session_params)
            session[:session_token] = @user.session_token
          #  @current_user ||= session[:session_token ] && User.find_by_session_token(session[:session_token])
            redirect_to movies_path
        else
            User.create_user!(session_params)
            flash[:notice] = "Incorrect User/Email Combination. Please try again"
            redirect_to login_path
        end
    end

  def destroy
    #Reset the session
    flash[:notice] ="Logged Out"
    session[:session_token] = nil
    redirect_to login_path
  end
end    