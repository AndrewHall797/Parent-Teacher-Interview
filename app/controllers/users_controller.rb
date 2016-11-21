class UsersController < ApplicationController

    
def new
        @user = User.new
end
    
def create
    @user = User.new(params.require(:user).permit(:email, :password, :password_confirmation, :name, :last_name))
    if @user.save
    flash[:notice] = "hank you for signing up!"
    redirect_to prin_user_path
    else
        render "new"
    end
end

def update
    @user = User.find(params[:id])
    if @user.update_attributes((params.require(:user).permit(:password, :password_confirmation)))
    flash[:notice] = "Thank you for updating!"
    redirect_to root_url
    else
        render "show"
    end
end
    
    
def prin
    @users=User.all
    @teachers = Teacher.all
end
    
def index
end
    
def show
        @user = User.find(params[:id])
end

def destroy

    @user = User.find(params[:id])
    @user.destroy
   
   redirect_to prin_user_path

end

def schedule
    @schedule = Teacher.find(params[:teacher_account])
    @schedule.reserved[params[:place].to_i] = "Reserved for #{@username = User.find(session[:user_id]).name}  #{@username = User.find(session[:user_id]).last_name}"
    @schedule.save
    redirect_to "https://database-tjthekid.c9users.io/student_page"
    
end

end
 