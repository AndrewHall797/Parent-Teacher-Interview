class User < ActiveRecord::Base
    
    #Secure password attribute
    has_secure_password
    
    #Password must validate uniqness of email, so email can nly be used once
    validates_uniqueness_of :email
    
    #Create roles
    ROLE_LIST = ["Teacher", "Student"]
    #Enters your times as an array
    serialize :your_times, Array

end
