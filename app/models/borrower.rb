class Borrower < ActiveRecord::Base

  has_many :books

  validates_presence_of :name

  before_create :generate_code

  def overdue_books
    books.select { |b| b.overdue? }
  end

  def available_books
    Book.available
  end

  def at_limit?
    limit && current_loan_count >= limit
  end

  def current_loan_count
    books.size
  end

  def current_overdue_count
    overdue_books.size
  end

  private

  def generate_code
    self.code ||= "B%08d" % rand(99_999)
  end

end
