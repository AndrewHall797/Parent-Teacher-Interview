class TeachersController < ApplicationController

def new
    @teacher = Teacher.new
end

def create
    @teacher = Teacher.new(params.require(:teacher).permit(:email, :password, :password_confirmation, :name, :last, :times, :reserved))
    @teacher.reserved = ["Avalible","Avalible","Avalible","Avalible","Avalible","Avalible"]
    if @teacher.save
    redirect_to prin_user_path
    else
    render "new"
    
    end
end

def show
 @teacher = Teacher.find(params[:id])
end

def destroy

    @teacher = Teacher.find(params[:id])
    @teacher.destroy
    
    redirect_to prin_user_path
end

def reset
    @teacher = Teacher.find(session[:teacher_id])
        for i in 0..5
            index = i
            unless @teacher.reserved[i] == "Avalible"
             reservations = @teacher.reserved[index].split(" ")
             @user = User.find(reservations[4].to_i)
                for x in 0..3
                    unless @user.your_times[x] == "NA"
                        user_reservations = @user.your_times[x].split(" ")
                        if user_reservations[3].to_i == i
                         @user.your_times[x] = "NA"
                         @user.save
                        end
                    end
                end
                @teacher.reserved[index] = "Avalible"
            end
        end 
    @teacher.save
     redirect_to  teacher_page_path
end

    def teacher_remove_selected 
        
        string = params[:string1].split(" ")
        puts string[4]
        @teacher = Teacher.find(session[:teacher_id])
        @teacher.reserved[params[:place].to_i] = "Avalible"
        @teacher.save
        @user = User.find(string[4].to_i)
        @user.your_times[string[3].to_i] = "NA"
        @user.save
        redirect_to student_page_url     
        
    end

end
