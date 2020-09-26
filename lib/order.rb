require "CSV"

class Order

  def initialize(id, products, customer, fulfillment_status = :pending)

    legal_fulfillment_statuses = [:pending, :paid, :processing, :shipped, :complete]
    unless legal_fulfillment_statuses.include?(fulfillment_status)
      raise ArgumentError.new("invalid fulfillment status")
    end

    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status
  end

  attr_reader :id, :products, :customer, :fulfillment_status

  def total
    if products.length == 0
      return 0
    else
      total_cost = products.sum { |item, price| price }
      total_cost *= 1.075
      return total_cost.round(2)
    end
  end

  def add_product(product_name, price)
    if products.keys.any?(product_name)
      raise ArgumentError.new("This order already contains #{product_name}")
    end
    products[product_name] = price
    return products
  end

  def remove_product(product_name, price)
    unless products.keys.any?(product_name)
      raise ArgumentError.new("This order does not contain #{product_name}")
    end
    products.delete(product_name)
    return products
  end

  def self.parse_products(product_list)
    product_hash = {}
    separate_products = product_list.split(";")
    separate_products.each do |single_product|
      item_and_price = single_product.split(":")
      product_hash[item_and_price[0]] = item_and_price[1].to_f
    end
    return product_hash
  end

  def self.all
    all_orders = CSV.read("data/orders.csv").map { |order| Order.new(order[0].to_i,
                parse_products(order[1]),
                Customer.find(order[2].to_i),
                order[3].to_sym) }
    return all_orders
  end

  def self.find(id)
    return Order.all.find { |order| order.id == id }
  end

  def self.find_by_customer(customer_id)
    customer_orders = Order.all.select { |order| order.customer.id == customer_id }
    customer_orders.length > 0 ? customer_orders : nil
  end

end
