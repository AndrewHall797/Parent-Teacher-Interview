#Controls user login
class SessionsController < ApplicationController
  
  #Displays Login page
  def new
  end
  
  #Attempts to match the current student role with assoicated user ID/password in order to login
  def create
   if (params[:role]) == "Student" # If their role is a student 
     user = User.find_by_email(params[:email]) #Searchs for student by email
       if user && user.authenticate(params[:password]) # If the password matches the assoaicted account
        session[:user_id] = user.id #Finds their model user ID
        session[:role] = "Student" #Sets their online role to student
        redirect_to "https://database-tjthekid.c9users.io/student_page" #Redriect to student page
        @role = "Student" # Set model instance to student
       else
        render "new"#Re-display login page if incorrect
       end
    
   #Attempts to match the current teacher role with assoicated user ID/password in order to login
   elsif (params[:role]) == "Teacher"# If their role is a teacher
    teacher = Teacher.find_by_email(params[:email])#Searchs for teacher by email
       if teacher && teacher.authenticate(params[:password])# If the password matches the assoaicted account
        session[:teacher_id] = teacher.id #Finds their model user ID
        session[:role] = "Teacher"#Sets their online role to teacher
        redirect_to "https://database-tjthekid.c9users.io/teacher_page"#Redriect to teacher page
       else
        render "new"#Re-display login page if incorrect
       end 
       
   #Attempts to match the current principal role with assoicated user ID/password in order to login    
   elsif (params[:role]) == "Principle"# If their role is a principal
     prin = Prin.find_by_email(params[:email])#Searchs for principal by email
       if prin && prin.authenticate(params[:password])
        session[:prin_id] = prin.id
        session[:role] = "Principle"
        redirect_to "https://database-tjthekid.c9users.io/prin_page"#Redriect to principal page
       else
        render "new"#Re-display login page if incorrect
       end
   else
    redirect_to root_url#Rediriect to home page if all is wrong
   end
  end
 
 #Log out
  def destroy #Destorys current instance user
   session[:user_id] = nil #Empty current user
   redirect_to root_url #Redirect to home
  end

end
