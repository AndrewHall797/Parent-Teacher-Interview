class Tester < ApplicationMailer
    default from: "tjthekid@hotmail.com"
      
      
    def travel(teacher)
        
    @greeting = 'Hi poop face'
    
    @user=teacher.email
    @name=teacher.name
    
    mail to: @user, subject: "Testing mail"
    end

end
