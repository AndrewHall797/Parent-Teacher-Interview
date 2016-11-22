class PagesController < ApplicationController
    
    def home
    end
    
    def student_page
        @username = User.find(session[:user_id]).name
        @userlast = User.find(session[:user_id]).last_name
        @teacher = Teacher.all
    end
    
    def teacher_page
    unless (@username == Teacher.find(session[:teacher_id]).name)
        redirect_to "https://database-tjthekid.c9users.io/student_page"
    else
        
        @teachername = Teacher.find(session[:teacher_id]).name
        @teacherlast = Teacher.find(session[:teacher_id]).last
        @reservations = Teacher.find(session[:teacher_id]).reserved 
    end

    end
    
    def scheduling
        @whichteacher = Teacher.find(params[:teacher_account])
        @reservations = Teacher.find(params[:teacher_account]).reserved
    end

    def access
    end
 
    
end
