#Login Contoller controls what page the user will be directed to view
class PagesController < ApplicationController
    
    #Presnet the Login page called Home
    def home
    end
    
    #Redirects Teacher/Principal user back to their correspondsing pages if their role is not a student
    def student_page
        if session[:role] == "Teacher"
            redirect_to "https://database-tjthekid.c9users.io/teacher_page"#If they are a teacher redirect them back to their page
            return
        elsif session[:role] == "Principle"
            redirect_to "https://database-tjthekid.c9users.io/prin_page"#If they are a principal redirect them back to their page
            return
        end
        
        @user = User.find(session[:user_id])#Fid teacher user model
        @username = User.find(session[:user_id]).name
        @userlast = User.find(session[:user_id]).last_name
        @teacher = Teacher.all
    end
    
    #Redirects Student/Principal user back to their correspondsing pages if their role is not a teacher
    def teacher_page
        if session[:role] == "Student"
            redirect_to "https://database-tjthekid.c9users.io/student_page"
            return
        elsif session[:role] == "Principle"#If they are a principal redirect them back to their page
            redirect_to "https://database-tjthekid.c9users.io/prin_page"
            return
        end
        
        @teachername = Teacher.find(session[:teacher_id]).name
        @teacherlast = Teacher.find(session[:teacher_id]).last
        @reservations = Teacher.find(session[:teacher_id]).reserved 
    end

    #Redirects Teacher/Principal user back to their correspondsing pages in order to book off their selected time
    def scheduling
        if session[:role] == "Teacher"#If they are a teacher redirect them back to their page
            redirect_to "https://database-tjthekid.c9users.io/teacher_page"
            return
        elsif session[:role] == "Principle"#If they are a principal redirect them back to their page
            redirect_to "https://database-tjthekid.c9users.io/prin_page"#If they are a principal redirect them back to their page
            return
        end
        @user = User.find(session[:user_id]) #Find the defiened teacher
        @whichteacher = Teacher.find(params[:teacher_account]) #Select the desired teacher
        @reservations = Teacher.find(params[:teacher_account]).reserved #Resevres slected time slot
    end

end
