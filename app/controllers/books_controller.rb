class BooksController < ApplicationController

  def index
    @books = Book.all
    @book = Book.new
     @user = current_user

  end

  def show
    @new_book = Book.new
    @book = Book.find(params[:id])
     @user = @book.user
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if  @book.save
      flash[:notice] = "You have created book successfully"
    redirect_to book_path(@book.id)
    else
      @user = current_user
      @books = Book.all
      render 'index'
    end
  end

  def new
    @book = Book.new
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user == current_user
      render "edit"
    else
      redirect_to books_path
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy!
    redirect_to books_path
  end

  def update
    @book = Book.find(params[:id])
    @book.user_id = current_user.id
    if @book.update(book_params)
      redirect_to book_path(@book.id), notice:  "You have updated book successfully"
    else
      render :edit
    end
  end

  private

   def book_params
    params.require(:book).permit(:title, :body)
   end


end
