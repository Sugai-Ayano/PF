class GenresController < ApplicationController
  def index
    @genre = Genre.new
    @posts = nil

    if true # genreが何か選択されたときのみ検索処理をはしらせる
      @posts = Post.where(genre_id: params[:season]).page(params[:page]).per(9)
    end
  end
end
