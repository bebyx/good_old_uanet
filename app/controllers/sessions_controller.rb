class SessionsController < ApplicationController

   def new

   end

   def create
       user = User.find_by(email: params[:session][:email].downcase)
       if user && user.authenticate(params[:session][:password])
           session[:user_id] = user.id
           flash[:notice] = "Ви залогінилися. Вітаємо!"
           redirect_to user_path(user)
       else
           flash.now[:alert] = "Хибний емейл чи пароль."
           render 'new'
       end

   end

   def destroy
       session[:user_id] = nil
       flash[:notice] = "Ви вилогінилися."
       redirect_to records_path
   end

end
