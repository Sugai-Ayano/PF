class GenresController < ApplicationController
  def index
    @genre = Genre.new
    @genres = Genre.all
  end
end
