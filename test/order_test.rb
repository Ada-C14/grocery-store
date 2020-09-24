require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

require_relative '../lib/customer'
require_relative '../lib/order'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

describe "Order Wave 1" do
  let(:customer) do
    address = {
      street: "123 Main",
      city: "Seattle",
      state: "WA",
      zip: "98101"
    }
    Customer.new(123, "a@a.co", address)
  end

  describe "#initialize" do
    it "Takes an ID, collection of products, customer, and fulfillment_status" do
      id = 1337
      fulfillment_status = :shipped
      order = Order.new(id, {}, customer, fulfillment_status)

      expect(order).must_respond_to :id
      expect(order.id).must_equal id

      expect(order).must_respond_to :products
      expect(order.products.length).must_equal 0

      expect(order).must_respond_to :customer
      expect(order.customer).must_equal customer

      expect(order).must_respond_to :fulfillment_status
      expect(order.fulfillment_status).must_equal fulfillment_status
    end

    it "Accepts all legal statuses" do
      valid_statuses = %i[pending paid processing shipped complete]

      valid_statuses.each do |fulfillment_status|
        order = Order.new(1, {}, customer, fulfillment_status)
        expect(order.fulfillment_status).must_equal fulfillment_status
      end
    end

    it "Uses pending if no fulfillment_status is supplied" do
      order = Order.new(1, {}, customer)
      expect(order.fulfillment_status).must_equal :pending
    end

    it "Raises an ArgumentError for bogus statuses" do
      bogus_statuses = [3, :bogus, 'pending', nil]
      bogus_statuses.each do |fulfillment_status|
        expect {
          Order.new(1, {}, customer, fulfillment_status)
        }.must_raise ArgumentError
      end
    end
  end

  describe "#total" do
    it "Returns the total from the collection of products" do
      products = { "banana" => 1.99, "cracker" => 3.00 }
      order = Order.new(1337, products, customer)

      expected_total = 5.36

      expect(order.total).must_equal expected_total
    end

    it "Returns a total of zero if there are no products" do
      order = Order.new(1337, {}, customer)

      expect(order.total).must_equal 0
    end
  end

  describe "#add_product" do
    it "Increases the number of products" do
      products = { "banana" => 1.99, "cracker" => 3.00 }
      before_count = products.count
      order = Order.new(1337, products, customer)

      order.add_product("salad", 4.25)
      expected_count = before_count + 1
      expect(order.products.count).must_equal expected_count
    end

    it "Is added to the collection of products" do
      products = { "banana" => 1.99, "cracker" => 3.00 }
      order = Order.new(1337, products, customer)

      order.add_product("sandwich", 4.25)
      expect(order.products.include?("sandwich")).must_equal true
    end

    it "Raises an ArgumentError if the product is already present" do
      products = { "banana" => 1.99, "cracker" => 3.00 }

      order = Order.new(1337, products, customer)
      before_total = order.total

      expect {
        order.add_product("banana", 4.25)
      }.must_raise ArgumentError

      # The list of products should not have been modified
      expect(order.total).must_equal before_total
    end
  end

  describe "#remove_product" do
    it "It decreases the number of products" do
      products = { "cheese" => 6.59, "apple" => 1.00 }
      before_count = products.count
      order = Order.new(1234, products, customer)

      order.remove_product("apple")
      expected_count = before_count - 1

      expect(order.products.count).must_equal expected_count
    end

    it "Is removed from the collection of products" do
      products = { "cheese" => 6.59, "apple" => 1.00 }
      order = Order.new(1234, products, customer)

      order.remove_product("cheese")
      expect(order.products.include?("cheese")).must_equal false
    end

    it "Raises an ArgumentError if a product is not in the collection" do
      products = { "cheese" => 6.59, "apple" => 1.00 }
      order = Order.new(1234, products, customer)
      before_total = order.total

      expect{
        order.remove_product("peanuts")
      }.must_raise ArgumentError

      expect(order.total).must_equal before_total
    end
  end
end

# TODO: change 'xdescribe' to 'describe' to run these tests
describe "Order Wave 2" do
  describe "Order.all" do
    it "Returns an array of all orders" do
      orders = Order.all

      expect(orders.length).must_equal 100
      orders.each do |c|
        expect(c).must_be_kind_of Order
        expect(c.id).must_be_kind_of Integer
        expect(c.products).must_be_kind_of Hash
        expect(c.customer).must_be_kind_of Customer
        expect(c.fulfillment_status).must_be_kind_of Symbol
      end
    end

    it "Returns accurate information about the first order" do
      id = 1
      products = {
        "Lobster" => 17.18,
        "Annatto seed" => 58.38,
        "Camomile" => 83.21
      }
      customer_id = 25
      fulfillment_status = :complete

      order = Order.all.first

      # Check that all data was loaded as expected
      expect(order.id).must_equal id
      expect(order.products).must_equal products
      expect(order.customer).must_be_kind_of Customer
      expect(order.customer.id).must_equal customer_id
      expect(order.fulfillment_status).must_equal fulfillment_status
    end

    it "Returns accurate information about the last order" do
      id = 100
      products = {
          'Amaranth' => 83.81,
          'Smoked Trout' => 70.60,
          'Cheddar' => 5.63
      }
      customer_id = 20
      fulfillment_status = :pending

      order = Order.all.last

      expect(order.id).must_equal id
      expect(order.products).must_equal products
      expect(order.customer).must_be_kind_of Customer
      expect(order.customer.id).must_equal customer_id
      expect(order.fulfillment_status).must_equal fulfillment_status
    end
  end

  describe "Order.find" do
    it "Can find the first order from the CSV" do
      first = Order.find(1)

      expect(first).must_be_kind_of Order
      expect(first.id).must_equal 1
    end

    it "Can find the last order from the CSV" do
      last = Order.find(100)

      expect(last).must_be_kind_of Order
      expect(last.id).must_equal 100
    end

    it "Returns nil for an order that doesn't exist" do
      expect(Order.find(12345)).must_be_nil
    end
  end

  describe "Order#find_by_customer" do
    it "Returns at list of orders where the customer ID matches" do
      customer_id = 25

      orders_by_customer = Order.find_by_customer(customer_id)

      expect(orders_by_customer).must_be_kind_of Array
      expect(orders_by_customer.length).must_equal 6
      orders_by_customer.each do |order|
        expect(order.customer.id).must_equal 25
      end
    end

    it "Returns nil when the customer ID is not found" do
      customer_id = 50
      expect(Order.find_by_customer(customer_id)).must_be_nil
    end
  end
end
