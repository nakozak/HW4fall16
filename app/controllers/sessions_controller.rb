class SessionsController < ApplicationController
   
    def session_params
        params.require(:user).permit(:user_id, :email, :session_token)
    end
    
    def new
    end
    
    def create
        #Check to see if the user exists in the database
        #if the user exists, create a session token and redirect to the user to the movies path
        if(User.exists?(:user_id=> session_params[:user_id]) && User.exists?(:email => session_params[:email]))
            flash[:notice] = "You are logged in as #{session_params[:user_id]}"
            #get user id, email, and session token corresponding to the session token
            @user = User.find_by(session_params)
            @email = User.find_by(session_params)
            session[:session_token] = @user.session_token
            redirect_to movies_path
        else
            #Tries to create user with the session parameters, but if the email and user id don't match 
            #the user is redirected to the login path  
            User.create_user!(session_params)
            flash[:notice] = "Incorrect User/Email Combination. Please try again"
            redirect_to login_path
        end
    end

  def destroy
    #Log user out by deleting the session token and redirecting to the login path
    flash[:notice] ="Logged Out"
    session[:session_token] = nil
    redirect_to login_path
  end
end    