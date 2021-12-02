class AdSearchingService
  def initialize(query_hash, scope)
    @query_hash = query_hash
    @scope = scope
  end

  def call
    return scope if @query_hash.blank?

    filter_price
    filter_color

    @query_hash.compact_blank.each do |key, value|
      @scope = @scope.search_ads(key.downcase, value.downcase)
    end

    @scope
  end

  def filter_price
    return if @query_hash[:price].blank?

    @query_hash[:price] = @query_hash[:price].to_i

    if @query_hash[:price] == 50
      @scope = @scope.where('price > 5000000')
    else
      @scope = @scope.where('price < ?', @query_hash[:price])
    end

    @query_hash = @query_hash.except(:price)
  end

  def filter_color
    return if ["black", "white", ""].include? @query_hash[:color].downcase

    @query_hash[:color_detail] = @query_hash[:color]
    @query_hash = @query_hash.except(:color)
  end

end
