class UsersController < ApplicationController

# Creates a new User and stores that user as a variable, the new view is were the atributes of the new user is entered.
def new
        @user = User.new
end
#saves the atributes of the new user object into the model.
def create
    @user = User.new(params.require(:user).permit(:email, :password, :password_confirmation, :name, :last_name))
    @user.your_times = ["NA","NA","NA","NA"]
    if @user.save
    redirect_to prin_user_path
    else
        render "new"
    end
end
#Updates the information of the user that is stores in the model.
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
  #shows the information of the selected user. 
def show
        @user = User.find(params[:id])
end
# removes the user selected from the array.
def destroy

    @user = User.find(params[:id])
    @user.destroy
   
   redirect_to prin_user_path

end
# reserves times that the user selected with the teacher 
def schedule
    
    #Tester.travel(Teacher.find(params[:teacher_account])).deliver
   
    @user = User.find(session[:user_id])
    @teacher = Teacher.find(params[:teacher_account])
    
    if @teacher.reserved[params[:place].to_i] == "Avalible"
        @teacher.reserved[params[:place].to_i] = "Reserved for #{@user.name}  #{@user.last_name}"
        @teacher.save
        
        keep_searching = true
        
        for i in 0..3       
            if @user.your_times[i] == "NA" and keep_searching == true
                @user.your_times[i] = "#{params[:place]} #{@teacher.name} #{@teacher.id.to_i} #{params[:place].to_i}"
                keep_searching = false
                @user.save
            end
        end
        
    end
    redirect_to "https://database-tjthekid.c9users.io/student_page"
    
end
 
 def clear_schedule
 
    @user = User.find(session[:user_id])
    for i in 0..3
    string = @user.your_times[i]
        remove_reservations(string[2], string[3])
    end
    @user.your_times = ["NA","NA","NA","NA"]
    @user.save
    redirect_to student_page_url
 
 end
 
 def remove_reservations (teacher_id,time)
        @teacher = Teacher.find(params[:teacher_id])
        @teacher.reserved[time] = "Reserved"
        @teacher.save
 end
 
end
 