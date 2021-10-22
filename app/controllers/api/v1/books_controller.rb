class Api::V1::BooksController < Api::V1::BaseController
  include JwtAuthenticator
  before_action :authenticate_identical!

  before_action :set_book, only: %w[show update]

  def index
    books = Book.recent.page(params[:page]).per(params[:per_page])
    return no_books_found if books.blank?

    render json: books, each_serializer: Api::V1::BookSerializer
  end

  def show
    book = Book.find_by(id: params[:id])
    return no_books_found if book.blank?

    render json: book, serializer: Api::V1::BookSerializer
  end

  def destroy
    outcome = ::Books::Destroy.run({ id: params[:id] })
    if outcome.valid?
      render json: { message: 'Book destroyed successfully.' }
    else
      render json: { errors: outcome.errors.as_json }, status: :internal_server_error
    end
  end

  def create
    @book = Book.new
    save_book
  rescue ActionController::ParameterMissing
    render json: { errors: 'Invalid params!' }, status: :internal_server_error
  end

  def update
    save_book
  rescue ActionController::ParameterMissing
    render json: { errors: 'Invalid params!' }, status: :internal_server_error
  end

  private

  def set_book
    @book = Book.find_by(id: params[:id])
  end

  def save_book
    inputs = { book: @book, attrs: book_params }
    outcome = ::Books::CreateOrUpdate.run(inputs)

    if outcome.valid?
      render json: outcome.result, serializer: Api::V1::BookSerializer
    else
      render json: { errors: outcome.errors.as_json }, status: :internal_server_error
    end
  end

  def book_params
    params.require(:book).permit(:name, :price, :admin_user_id)
  end

  def no_books_found
    render json: {
      errors: 'No books match your search criteria'
    }, status: :not_found
  end
end
