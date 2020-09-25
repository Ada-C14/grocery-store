class Order

  attr_reader :id, :products, :customer, :fulfillment_status

  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status
    if %w[pending paid processing shipped complete].include? (fulfillment_status)
      @fulfillment_status = fulfillment_status
    else
      raise ArgumentError.new("#{fulfillment_status} is an invalid fulfillment status")
    end
  end


end

