class BooksController < ApplicationController
  load_and_authorize_resource
  def index
    @books = Book.all
  end
end