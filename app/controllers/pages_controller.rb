class PagesController < ApplicationController
    
    def home
    end
    
    def student_page
        unless session[:role]== "Student"
        redirect_to "https://database-tjthekid.c9users.io/teacher_page"
        return
        end
        
        @user = User.find(session[:user_id])
        @username = User.find(session[:user_id]).name
        @userlast = User.find(session[:user_id]).last_name
        @teacher = Teacher.all
    end
    
    def teacher_page
        unless session[:role]== "Teacher"
        redirect_to "https://database-tjthekid.c9users.io/student_page"
        return
        end
        
        @teachername = Teacher.find(session[:teacher_id]).name
        @teacherlast = Teacher.find(session[:teacher_id]).last
        @reservations = Teacher.find(session[:teacher_id]).reserved 
    end

    
    def scheduling
        @whichteacher = Teacher.find(params[:teacher_account])
        @reservations = Teacher.find(params[:teacher_account]).reserved
    end

end
