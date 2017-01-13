class SessionsController < ApplicationController
  
  def new
  end
  
  def create
   if (params[:role]) == "Student"  
     user = User.find_by_email(params[:email])
       if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        session[:role] = "Student"
        redirect_to "https://database-tjthekid.c9users.io/student_page"
        @role = "Student"
       else
        render "new"
       end
    
   elsif
    teacher = Teacher.find_by_email(params[:email])
       if teacher && teacher.authenticate(params[:password])
        session[:teacher_id] = teacher.id
        session[:role] = "Teacher"
        redirect_to "https://database-tjthekid.c9users.io/teacher_page"
       else
        render "new"
       end 
   else
     prin = Prin.find_by_email(params[:email])
       if prin && prin.authenticate(params[:password])
        session[:prin_id] = prin.id
        redirect_to "https://database-tjthekid.c9users.io/prin_page"
       else
        render "new"
       end
   end
  end
 
  def destroy
   session[:user_id] = nil
   redirect_to root_url
  end

end
