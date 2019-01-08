#Controls Pcinipal/Amdin account creation
class PrinsController < ApplicationController
    
    #Create a new Principal model
    def new
        @prin = Prin.new #Creat new model instance
    end
    
    #Attempts to create a new Princiapl model, if unsuccussfull, it will repeat the login process, displayed the coressponding error
    def create
        @prin = Prin.new(params.require(:prin).permit(:email, :password, :password_confirmation, :name, :last_name)) # Try to create a priniapal user with the following attrtubtes
            if @prin.save # If the priniapl save, display a sign up message
                flash[:notice] = "Thank you for signing up!"
                redirect_to prin_user_path #Redirect to home page
            end
    end
    
    #Desotrys/Logout the current Principal user
    def destroy
        @prin = Prin.find(params[:id]) #Find current Principal user
        @prin.destroy #Delete current selected user
    
        redirect_to prin_user_path #Redirect to home page
    end

end
