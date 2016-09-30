class UsersController < ApplicationController
  
  def user_params
    params.require(:user).permit(:user_id, :email, :session_token)  
  end
  
  def new
  end
  
  def edit
  end
  
  def create
    #Creates new user based on the user+params defined above
    #Checks to see if the user id is registered before sign up
    @user = params[:user_id]
    if(User.exists?(:user_id => user_params[:user_id]))
      flash[:notice]  = "Sorry, this user-id is taken."
      redirect_to new_user_path
    else
      @user = User::create!(user_params)
      flash[:notice] = "Welcome #{@user.user_id}. Your account has been created"
      redirect_to login_path
    end
  end
  
  def index
    @users = User.all
  end
  
  def update
  end
  
  def destroy
  end
  
 
end