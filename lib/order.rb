class Order
  attr_reader :id, :products, :customer, :fulfillment_status, :expected_total

  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status
    @expected_total = 0

    status_options = [:pending, :paid, :processing, :shipped, :complete]
    if !(status_options.include?(fulfillment_status))
      raise ArgumentError.new("Invalid status")
    end
  end

  # def product_list(product, cost)
  #   @products = {product => cost}
  #   return @products
  # end

  def total
    total = 0
    @products.each_value do |cost|
      total += cost
    end

    calculate_tax = total * 0.075
    @expected_total = total + calculate_tax
    return @expected_total.round(2)
  end

  def add_product(product_name, price)
    before_count = @products.count

    new_product = {product_name => price}
    if @products.include?(product_name)
      raise ArgumentError.new("That product already exists") #Do i need to add in an optional gets.chomp?
    end

    @products.merge!(new_product) #why does this work?
    expected_count = before_count + 1
    return expected_count
  end
end

# emily = Customer.new('412', 'emily@gmail.com', '235928759')
#
# emily = Order.new('234', {"coffee" => 2.00}, customer, :pending)
# p emily