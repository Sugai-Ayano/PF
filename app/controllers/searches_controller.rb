class SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @model = params[:model]
		@content = params[:content]
		@method = params[:method]
		@user = current_user

		if @model == 'user'
			@records = User.search_for(@content, @method)
		else
			@records = Post.search_for(@content, @method)
		end
  end
end
