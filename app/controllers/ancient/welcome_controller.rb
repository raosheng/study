class Ancient::WelcomeController < Ancient::HighController
   before_action :authenticate_user!, exept: [:index] 
 def index
 end
end