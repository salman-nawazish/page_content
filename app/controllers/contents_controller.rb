class ContentsController < ApplicationController
    before_filter :check_parameters, :only => :create

    def index
		@links = Link.all
		render :json => {:status => :ok, :links => @links}
	end

	
	def create
		Content.save_content(params[:url])
		render :json => {:status => :ok, :message => "content created"}
	end

	private

    def check_parameters
    	unless params[:url].present? and params[:url] =~ /\A#{URI::regexp}\z/
    		render :json => {:status => :bad_request, :message => "Please provide a valid complete URL including http/https"}
    	end
    end

end
