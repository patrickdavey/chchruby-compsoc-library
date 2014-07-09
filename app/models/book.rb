class Book < ActiveRecord::Base

  scope :available, -> { where borrower_id: nil }

  belongs_to :borrower

  validates_presence_of :title, :author

  def on_loan?
    # !! is a ruby idiom that converts a 'truthy' value to true.
    # It simply applies the negation operator (!) twice.
    #
    # In this case, borrower can either be a Borrower object or nil
    # If borrower is set:
    #   !!borrower => !(!#<Borrower>) => !(false) => true
    #   !!borrower => !(!nil)         => !(true)  => false
    !!borrower
  end

  def borrower_name
    borrower.name if borrower
  end

  def overdue?
    due_on && due_on < Date.today
  end

  def days_until_due
    due_on - Date.today if due_on
  end

  def keyword_array
    [title, author, keywords].compact.flat_map(&:split).map(&:downcase)
  end

end
