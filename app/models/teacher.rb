class Teacher < ActiveRecord::Base

       has_secure_password
       
       validates_uniqueness_of :email
       
       serialize :reserved, Array
    
end
