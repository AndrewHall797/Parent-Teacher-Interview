class Teacher < ActiveRecord::Base

       #teacher must have secure password
       has_secure_password
       
       #Must have a unique email, only 1 can be used
       validates_uniqueness_of :email
       
       #Save data array
       serialize :reserved, Array
    
end
