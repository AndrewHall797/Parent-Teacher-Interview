#Controls teacher model creation/destruction
class TeachersController < ApplicationController

#Dircet tocreating a new teacher page
def new
    @teacher = Teacher.new #Create a new teacher instance
end
 
#Try to create a new teacher
def create
    @teacher = Teacher.new(params.require(:teacher).permit(:email, :password, :password_confirmation, :name, :last, :times, :reserved)) #Create a new teacher instance with set variables
    @teacher.reserved = ["Avalible","Avalible","Avalible","Avalible","Avalible","Avalible","Avalible","Avalible","Avalible","Avalible","Avalible","Avalible"] #Create teacher time slots
    if @teacher.save#If teacher saves correctly
    redirect_to prin_user_path #Redirect to the home page
    else
    render "new" #If else, redirect back to creation screen
    
    end
end

#Display teacher Information
def show
 @teacher = Teacher.find(params[:id]) #Find teacher form current user ID
end

#Delete Teacher Method
def destroy

    @teacher = Teacher.find(params[:id]) #Select current teacher ID
    @teacher.destroy #Deelte the instance teacher
    
    redirect_to prin_user_path #redirect to home
end

#Resets teacher schdule
def reset
    @teacher = Teacher.find(session[:teacher_id]) #Find selected teacher ID
        for i in 0..11 # Statmetns for yoru schdules
            index = i
            unless @teacher.reserved[i] == "Avalible" #Checks to see if slot slected is available
             reservations = @teacher.reserved[index].split(",") #Creates a , to set a slot as available
             @user = User.find(reservations[4].to_i)#Looks to fill up all 4 slots
                for x in 0..3 #reapeats untill not options available
                    unless @user.your_times[x] == "NA" #Replaces NA with your current times
                        user_reservations = @user.your_times[x].split(",")
                        if user_reservations[3].to_i == i #Repeat unless stopped by impcomplete forum
                         @user.your_times[x] = "NA" #Save your time
                         @user.save #Save user schdule
                        end
                    end
                end
                @teacher.reserved[index] = "Avalible" # Set slot as available
            end
        end 
    @teacher.save #Saves schdules, and updates for all users
     redirect_to  teacher_page_path
end

    #Remove/delete selected tiem slot
    def teacher_remove_selected 
        
        string = params[:string1].split(",")#Select string by adding a , to the string
        @teacher = Teacher.find(session[:teacher_id]) #Find teacher with the corresponding ID
        @teacher.reserved[params[:place].to_i] = "Avalible" #String maniuplation to change ,
        @teacher.save#Save teacher
        @user = User.find(string[4].to_i)  #Repeat down the list
        y=0
        for x in @user.your_times#Removes selected time from your schedule
                if x.split(",")[1] == @teacher.name
                    @user.your_times[y] = "NA"#Reset time to NA
                end
            y+=1
        end
        @user.save
        redirect_to student_page_url#Direct to student Home
        
    end
    
    #Updates teacher schedule
    def update
        @teacher = Teacher.find(params[:id])# Find teacher ID
        if @teacher.update_attributes((params.require(:teacher).permit(:password, :password_confirmation))) #Trys to update teacher attributes
        redirect_to prin_page_path#If successful, save and redirect to the home admin page
        else
            render "show"#Redisplay create page
        end
    end

end
