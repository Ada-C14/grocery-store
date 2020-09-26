
class Order

  attr_reader :id, :products, :customer, :fulfillment_status

  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products
    @customer = customer
    if [:pending, :paid, :processing, :shipped, :complete].include?(fulfillment_status)
      @fulfillment_status = fulfillment_status
    else
      raise ArgumentError, "Invalid fulfillment status."
    end
  end


  def total
    return 0 if @products.empty?
    sum = @products.sum {|item, cost| cost}
    total = sum * 1.075
    return total.round(2)
  end

  def add_product(product_name, product_price)
    if @products.include?(product_name)
      raise ArgumentError, "This product is already included in our inventory."
    else
      @products[product_name] = product_price
    end
  end

  def remove_product(product_name, product_price)
    if @products.include?(product_name) == false
      raise ArgumentError, "This product is not in inventory."
    else @products.reject! {|key| key == product_name}
    end
  end

end
