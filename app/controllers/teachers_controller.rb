class TeachersController < ApplicationController

def new
    @teacher = Teacher.new
end

def create
    @teacher = Teacher.new(params.require(:teacher).permit(:email, :password, :password_confirmation, :name, :last, :times, :reserved))
    @teacher.reserved = ["Avalible","Avalible","Avalible","Avalible","Avalible","Avalible"]
    if @teacher.save
    flash[:notice] = "Thank you for signing up!"
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
                    puts "Hello"
                        user_reservations = @user.your_times[x].split(" ")
                        puts user_reservations[3]
                        puts i
                        if user_reservations[3].to_i == i
                            puts "I got here"
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

end
