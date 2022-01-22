class BooksController < ApplicationController

  def index
    @books = Book.all
    @book = Book.new
     @user = current_user

  end

  def show
    @new_book = Book.new
    @book = Book.find(params[:id])
     @user = current_user
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @book.save
    redirect_to book_path(@book.id)
  end

  def new
    @book = Book.new
  end

  def edit
    @book = Book.find(params[:id])
    @book.user = current_user
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
