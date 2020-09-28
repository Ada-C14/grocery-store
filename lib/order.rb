class Order
  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status

  def initialize(id, products, customer, fulfillment_status = :pending)
    @tax = 1.075
    @allowable_statuses = [:pending, :paid, :processing, :shipped, :complete]
    raise ArgumentError.new("ID must be a number") unless id.class == Integer
    @id = id
    raise ArgumentError.new("Products must be a hash") unless products.class == Hash
    @products = products
    unless customer.class == Customer
      raise ArgumentError.new("Customer must be instance of Customer class")
    end
    @customer = customer
    unless @allowable_statuses.include?(fulfillment_status)
      string = "Fulfullment status invalid\n Must be one of the following: "
      @allowable_statuses.each { |status| string < status.to_s }
      raise ArgumentError.new(string)
    end
    @fulfillment_status = fulfillment_status
  end

  def total
    return (products.values.sum * @tax).round(2)
  end

  def add_product(product_name, price)
    raise ArgumentError.new("Product already exists") if @products.has_key?(product_name)
    @products[product_name] = price
  end

  def self.all
    orders = []
    @path = './data/orders.csv'
    raise LoadError.new("Order DB not found!") unless File.exist?(@path)
    order_csv = CSV.read(@path).map { |row| row.to_a }

    order_csv.each do |order|
      # Split order string into hash of orders
      products = {}
      products_ordered = order[1].split(';')
      products_ordered.each do |pair|
        pair = pair.to_s.split(':')
        products[pair[0]] = pair[1].to_f
      end

      # Use Customer.find to turn Customer ID into Customer object
      customer_obj = Customer.find(order[2].to_i)
      orders << Order.new(order[0].to_i, products, customer_obj, order[3].to_sym)
    end

    return orders
  end

end