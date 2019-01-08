#Mail sending method
 Tester < ApplicationMailer
    default from: "tjthekid@hotmail.com"
      
     #Sends user mail to selected teacher
    def travel(teacher)
    
    #Set greeting    
    @greeting = 'Hi test'
    
    #Select teacher user
    @user=teacher.email
    @name=teacher.name
    
    #Mail to teachers email
    mail to: @user, subject: "Testing mail"
    end

end
