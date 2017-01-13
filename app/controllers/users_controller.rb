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
        @prins = Prin.all
    end
     
    def index
        @user = User.search(params[:search])
        
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
        can_schedule = true
        
        for x in @teacher.reserved
            if "Avalible" != x
                can_schedule = false
            end
        end
            
        if can_schedule == true
            if @teacher.reserved[params[:place].to_i] == "Avalible"
                @teacher.reserved[params[:place].to_i] = "Reserved for #{@user.name} #{@user.last_name} #{@user.id}" 
                @teacher.save
                    
                keep_searching = true
                    
                for i in 0..3       
                    if @user.your_times[i] == "NA" and keep_searching == true
                        @user.your_times[i] = "#{params[:place]} #{@teacher.name} #{@teacher.id} #{params[:place].to_i}"
                        keep_searching = false
                        @user.save
                    end
                end
            end
        end
        redirect_to "https://database-tjthekid.c9users.io/student_page"
        
    end
     
 def clear_schedule
     
    @user = User.find(session[:user_id])
    for i in 0..3
    string = @user.your_times[i].split(" ")
    puts string[2]
        remove_reservations(string[2], string[3], i)
    end
    @user.your_times = ["NA","NA","NA","NA"]
    @user.save
    redirect_to student_page_url
 
 end
 
 def remove_reservations (teacher_id,time,place)
      
      @user = User.find(session[:user_id])
        
        unless @user.your_times[place] == "NA"
            @teacher = Teacher.find(teacher_id)
            @teacher.reserved[time.to_i] = "Avalible"
            @teacher.save
        end
 end
 
 def remove_selected 
    
        string = params[:string1]
        @teacher = Teacher.find(string[2].to_i)
        @teacher.reserved[string[3].to_i] = "Avalible"
        @teacher.save
        @user = User.find(session[:user_id])
        @user.your_times[params[:place].to_i] = "NA"
        @user.save
        redirect_to student_page_url
        
 end
 
 # The auito scheduler method creates a schedule for the user autimaticly by taking four teachers from a form in the student_page view and finding the optimal times for the user.
 def auto_create_schedule
     how_many_teachers = -1
    clear_schedule_private()
    unless params[:teacher1] == ""
        @teacher1 = Teacher.find(params[:teacher1])
        how_many_teachers +=1
    else
        @teacher1 = nil
    end
    teacher1_times = help_auto(params[:teacher1])
    unless params[:teacher2] == ""
        @teacher2 = Teacher.find(params[:teacher2])
        how_many_teachers +=1
    else
        @teacher2 = nil
    end
    teacher2_times = help_auto(params[:teacher2])
    unless params[:teacher3] == ""
        @teacher3 = Teacher.find(params[:teacher3])
        how_many_teachers +=1
    else
        @teacher3 = nil
    end
    teacher3_times = help_auto(params[:teacher3])
    unless params[:teacher4] == ""
        @teacher4 = Teacher.find(params[:teacher4])
        how_many_teachers +=1
    else
        @teacher4 = nil
    end
    teacher4_times = help_auto(params[:teacher4])
    
   all_times = teacher1_times + teacher2_times + teacher3_times + teacher4_times
   all_times -= [""]
   sorted_all_times = all_times.sort_by(&:to_i)
   new_schedule = [" "," "," "," "]
   
   keep_running = true
   general_time = params[:user_time]
   initial_num = general_time
   place = 0
   how_change = 1
   what_operation = 1
   max_value = false
   min_value = false

   until keep_running == false
    for x in sorted_all_times
     if x.split(" ")[0] == general_time
         if x.split(" ")[0] == new_schedule[place-1].split(" ")[0]
         else
            new_schedule[place] = x
            place+=1
            for y in sorted_all_times
                if y.split(" ")[0] == general_time
                    sorted_all_times -= [y]
                elsif y.split(" ")[1] == x.split(" ")[1]
                    sorted_all_times -= [y]
                end
            end
         end
     end
    end
     if initial_num == "5"
          general_time = "#{general_time.to_i - how_change}"
          how_change +=1
        elsif initial_num == "0"
          general_time = "#{general_time.to_i + how_change}"
          how_change +=1
        else
          general_time = "#{general_time.to_i + how_change}"
          how_change += what_operation
          how_change *=   -1
          what_operation*= -1
            if general_time == 6
                max_value = true
            elsif general_time == -1
                min_value = 6
            end
     end 
    if place > how_many_teachers or( max_value == true and min_value == true )
        keep_running = false
    end
   end
    puts new_schedule
    
    for x in new_schedule
        if @teacher1 != nil and x.split(" ")[1] == @teacher1.name
            auto_schedule_helper(@teacher1,x)
        end
        if @teacher2 != nil and x.split(" ")[1] == @teacher2.name
            auto_schedule_helper(@teacher2,x)
        end
        if @teacher3 != nil and x.split(" ")[1] == @teacher3.name
            auto_schedule_helper(@teacher3,x)

        end
        if @teacher4 != nil and x.split(" ")[1] == @teacher4.name
            auto_schedule_helper(@teacher4,x)
        end
    end
    
    redirect_to student_page_url
 end
 
 private def help_auto (teacher)
  if teacher == ""
        teacher_times = [""]
  else
      @teacher = Teacher.find(teacher)
      teacher_times = @teacher.reserved
      x = 0
      for i in teacher_times
        if teacher_times[x] == "Avalible"
            teacher_times[x] = "#{x} #{@teacher.name}"
        else
            teacher_times[x] = ""
        end
        x +=1
      end
  end
 return teacher_times
end
 
 private def clear_schedule_private
     
    @user = User.find(session[:user_id])
    for i in 0..3
    string = @user.your_times[i].split(" ")
    puts string[2]
        remove_reservations(string[2], string[3], i)
    end
    @user.your_times = ["NA","NA","NA","NA"]
    @user.save
 
 end
 
 private def auto_schedule_helper(teacher,time)
 
        #Tester.travel(Teacher.find(params[:teacher_account])).deliver
       
        @user = User.find(session[:user_id])
        @teacher = teacher
        place = time.split(" ")[0]
        
        if @teacher.reserved[place.to_i] == "Avalible"
            @teacher.reserved[place.to_i] = "Reserved for #{@user.name}  #{@user.last_name} #{@user.id}" 
            @teacher.save
            
            keep_searching = true
            
            for i in 0..3       
                if @user.your_times[i] == "NA" and keep_searching == true
                    @user.your_times[i] = "#{place} #{@teacher.name} #{@teacher.id} #{place.to_i}"
                    keep_searching = false
                    @user.save
                end
            end
            
        end
 end
 
end
 