class PrinsController < ApplicationController
    
    def new
        @prin = Prin.new
    end
    
    def create
        @prin = Prin.new(params.require(:prin).permit(:email, :password, :password_confirmation, :name, :last_name))
            if @prin.save
                flash[:notice] = "Thank you for signing up!"
                redirect_to prin_user_path
            end
    end
    
    def destroy
        @prin = Prin.find(params[:id])
        @prin.destroy
    
        redirect_to prin_user_path
    end

end
