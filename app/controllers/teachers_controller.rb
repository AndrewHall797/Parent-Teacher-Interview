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
    index = 0
    @teacher = Teacher.find(session[:teacher_id])
        @teacher.reserved.each do |x|
         @teacher.reserved[index] = "Avalible"
         index += 1
        end 
    @teacher.save
     redirect_to  teacher_page_path
end

end
