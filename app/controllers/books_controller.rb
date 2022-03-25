# frozen_string_literal: true

class BooksController < ApplicationController
  # GET /books
  # GET /books.json
  def index
    @books = Book.order(:id).page(params[:page])
  end

  # GET /books/1
  # GET /books/1.json
  def show
    @book = Book.includes(comments: :user).find(params[:id])
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
    @book = Book.find(params[:id])
  end

  # POST /books
  # POST /books.json
  def create
    @book = Book.new(book_params)

    respond_to do |format|
      if @book.save
        format.html { redirect_to @book, notice: t('controllers.common.notice_create', name: Book.model_name.human) }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    @book = Book.find(params[:id])

    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to @book, notice: t('controllers.common.notice_update', name: Book.model_name.human) }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book = Book.find(params[:id])

    @book.destroy
    respond_to do |format|
      format.html { redirect_to books_url, notice: t('controllers.common.notice_destroy', name: Book.model_name.human) }
      format.json { head :no_content }
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def book_params
    params.require(:book).permit(:title, :memo, :author, :picture)
  end
end
