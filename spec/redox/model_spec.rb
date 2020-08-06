# frozen_string_literal: true

RSpec.describe Redox::Model do
  class Email < Redox::Model
    redox_property :Address
  end

  class Author < Redox::Model
    redox_property :FirstName
    redox_property :LastName
    redox_property :Emails, coerce: Array[Email]
  end

  class Book < Redox::Model
    redox_property :ISBN
    redox_property :Title
    redox_property :WordCount
    redox_property :Author, coerce: Author
  end

  describe "from_redox_json" do
    it "maps CamelCase to snake_case" do
      book = Book.from_redox_json %(
        {
          "Title": "A Tale of Two Cities",
          "WordCount": 42
        }
      )
      expect(book.title).to eq("A Tale of Two Cities")
      expect(book.word_count).to eq(42)
    end

    it "maps ALL UPPERCASE to lowercase" do
      book = Book.from_redox_json '{"ISBN": "a-123"}'
      expect(book.isbn).to eq("a-123")
    end

    it "handles nested models" do
      book = Book.from_redox_json %(
        {
          "Title": "A Tale of Two Cities",
          "WordCount": 42,
          "Author": {
            "FirstName": "Charles",
            "LastName": "Dickens"
          }
        }
      )
      expect(book.author.first_name).to eq("Charles")
      expect(book.author.last_name).to eq("Dickens")
    end

    it "handles nested model Arrays" do
      book = Book.from_redox_json %(
        {
          "Title": "Some Book",
          "Author": {
            "FirstName": "Alice",
            "Emails": [
              { "Address": "a@example.com" },
              { "Address": "a@example.net" }
            ]
          }
        }
      )
      expect(book.title).to eq("Some Book")
      expect(book.author.first_name).to eq("Alice")
      expect(book.author.emails.map(&:address)).to eq(["a@example.com", "a@example.net"])
    end

    it "ignores extra propertes" do
      author = Author.from_redox_json %(
        {
          "FirstName": "Alice",
          "Emails": [
            {
              "Address": "a@example.com",
              "IgnoreMe": "IGNORE"
            }
          ]
        }
      )
      expect(author.first_name).to eq("Alice")
      expect(author.emails.map(&:address)).to eq(["a@example.com"])
      expect(author.emails.first.keys).to eq([:address])
    end
  end

  describe "to_redox_json" do
    it "generates Redox JSON" do
      book = Book.new isbn: "1-12-123", title: "foo", word_count: 42
      book.author = Author.new(first_name: "Max", last_name: "Headroom")

      expect(book.to_redox_json).to eq_json %(
        {
          "ISBN": "1-12-123",
          "Title": "foo",
          "WordCount": 42,
          "Author": {
            "FirstName": "Max",
            "LastName": "Headroom"
          }
        }
      )
    end

    it "handles nested model Arrays" do
      book = Book.new(
        title: "Some Book",
        author: Author.new(
          first_name: "Alice",
          emails: [Email.new(address: "alice@example.net")]
        )
      )

      expect(book.to_redox_json).to eq_json %(
        {
          "Title": "Some Book",
          "Author": {
            "FirstName": "Alice",
            "Emails": [
              { "Address": "alice@example.net" }
            ]
          }
        }
      )
    end
  end
end
