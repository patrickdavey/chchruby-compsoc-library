class CatalogueSearch

  def initialize(collection, params)
    @collection = Array(collection)
    @params     = params || {}
    @keyword    = @params.delete :keyword
  end

  def results
    @collection.select { |book| matches? book }
  end

private

  def matches?(book)
    (@params[:title] && book.title.downcase[@params[:title]]) ||
    (@params[:author] && book.author.downcase[@params[:author]]) ||
    (@keyword && book.keyword_array.any? { |k| k[@keyword.downcase] })
  end

end
