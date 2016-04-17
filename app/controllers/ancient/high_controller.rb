class Ancient::HighController < ApplicationController
	before_action :authenticate_user! 
	 
end