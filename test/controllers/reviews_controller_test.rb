require "test_helper"

describe ReviewsController do
  
  describe "create" do
      it "adds a book to the database" do
        book_data = {
          book: {
            title: "test book",
            author_id: Author.first.id
          }
        }
        post books_path, params: book_data
        must_redirect_to books_path
      end

      it "re-renders the new book form if the book is invalid" do
        book_data = { book: { title: "test book"} }
        post books_path, params: book_data
        must_respond_with :bad_request
      end
    end


end
