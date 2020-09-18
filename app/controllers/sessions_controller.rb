class SessionsController < ApplicationController

    def new

    end

    def create
        user = User.find_by(email: params[:session][:email].downcase)
        if user && user.authenticate(params[:session][:password])
            session[:user_id] = user.id
            flash[:notice] = "Login successfully"
            redirect_to user
        else
            #flash.now is used because we are not redirecting we are only rendering
            #Redirecting is http request response cycle while render is not
            flash.now[:alert] = "Incorrect username or password"
            render 'new'
        end
    end

    def destroy
        session[:user_id] = nil
        flash[:notice] = "Loged out"
        redirect_to root_path
    end

end