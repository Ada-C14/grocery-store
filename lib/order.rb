# Create a class called Order (W1.1)
class Order

  # ID should be readable but not writable
  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status

  # Define method initialize,
  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id # integer
    @products = products # empty hash
    @customer = customer

    list_of_status = [:pending, :paid, :processing, :shipped, :complete]
      if list_of_status.include? fulfillment_status
        @fulfillment_status = fulfillment_status
      else
        raise ArgumentError, "This is a invalid fulfillment status"
      end
  end

    # find total cost of an order
    def total
      total_cost = 0
      if @products.count == 0
        return  0
      end
      @products.each do |name, cost|
        total_cost += cost
      end
      total_cost += (total_cost * 0.075)
      return total_cost.to_f.round(2)
    end

  # Add product to an order, if it's a duplicate, raise exception
  def add_product(product_name, price)
    if @products.has_key?(product_name)
      raise ArgumentError, "Product already exists in the system"
    else
      @products[product_name] = price
    end
  end
end