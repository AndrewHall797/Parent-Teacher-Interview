class Prin < ActiveRecord::Base
    
    #Principals msut have secure password
    has_secure_password
    
    #Cannot ciopy emails, msut be unique
    validates_uniqueness_of :email
    
end
