# Pauline Chane (@PaulineChane on GitHub)
# Ada Developers Academy C14
# Grocery Store - order_test.rb
# 9/28/2020

# Minitests for Order class. Comments to note edits denoted with initials (PHC).

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
    it "Decreases the number of products" do
      products = { "banana" => 1.99, "cracker" => 3.00 }
      before_count = products.count
      order = Order.new(1337, products, customer)

      order.remove_product("banana")
      expected_count = before_count - 1
      expect(order.products.count).must_equal expected_count
    end

    it "Removes product from @products" do
      products = { "banana" => 1.99, "cracker" => 3.00 }
      order = Order.new(1337, products, customer)

      order.remove_product("banana")
      expect(order.products.include?("banana")).must_equal false
    end

    it "Raises an ArgumentError if the product is not present" do
      products = { "banana" => 1.99, "cracker" => 3.00 }

      order = Order.new(1337, products, customer)
      before_total = order.total

      expect {
        order.remove_product("canteloupe")
      }.must_raise ArgumentError

      # The list of products should not have been modified
      expect(order.total).must_equal before_total
    end
  end
end

# PHC: changed 'xdescribe' to 'describe' to run these tests
describe "Order Wave 2" do
  describe "Order.all" do
    it "Returns an array of all orders" do
      # PHC: added test code below
      # Arrange and Act
      orders = Order.all
      # Assert current number of instances in collection
      expect(orders.length).must_equal 100
      # Also assert correct data type per entry
      orders.each do |o|
        expect(o).must_be_kind_of Order

        expect(o.id).must_be_kind_of Integer
        expect(o.products).must_be_kind_of Hash
        expect(o.customer).must_be_kind_of Customer
        expect(o.fulfillment_status).must_be_kind_of Symbol
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
      # PHC: added test to match info typed manually from last line of file
      # Arrange
      id = 100
      products = {
          "Amaranth" => 83.81,
          "Smoked Trout" => 70.6,
          "Cheddar" => 5.63
      }
      customer_id = 20
      fulfillment_status = :pending
      # Act
      order = Order.all.last

      # Assert that all data was loaded as expected
      expect(order.id).must_equal id
      expect(order.products).must_equal products
      expect(order.customer).must_be_kind_of Customer
      expect(order.customer.id).must_equal customer_id
      expect(order.fulfillment_status).must_equal fulfillment_status
    end
  end

  describe "Order.find" do
    it "Can find the first order from the CSV" do
      # PHC: Added test code to find first order
      # Arrange and Act
      first = Order.find(1)

      # Assert correct data type and id
      expect(first).must_be_kind_of Order
      expect(first.id).must_equal 1
    end

    it "Can find the last order from the CSV" do
      # PHC: Added test code to find last order
      # Arrange and Act
      first = Order.find(100)

      # Assert correct data type and id
      expect(first).must_be_kind_of Order
      expect(first.id).must_equal 100
    end

    it "Returns nil for an order that doesn't exist" do
      # PHC: added test code to check for nil when non-existent order id entered
      expect(Order.find(2077)).must_be_nil
    end
  end

  # added tests for find_by_customer method
  describe "Order.find_by_customer" do
    it "can find all orders for a customer id from csv" do
      all_orders_30 = Order.find_by_customer(30)

      # Assert
      expect(all_orders_30).must_be_instance_of Array # current return type
      expect(all_orders_30.length).must_equal 3 # correct num orders

      all_orders_30.each do |o|
        expect(o.customer.id).must_equal 30 # correct customer id
        expect(o).must_be_instance_of Order # correct object type
      end
    end

    it "can pull correct order from Order.all based off input customer id" do
      # Arrange using a customer with only one order
      order_id = 65
      products = {"ThymeTofu" => 49.53,
                  "Pineapple" => 13.81,
                  "Porcini mushrooms" => 8.98,
                  "Bonito Flakes" => 92.0}
      customer_id = 32
      fulfill = :complete

      # Act
      all_orders_32 = Order.find_by_customer(32)

      # Assert
      expect(all_orders_32.length).must_equal 1 # confirm only 1 order

      # check that addtl data was correctly loaded
      expect(all_orders_32[0].id).must_equal order_id
      expect(all_orders_32[0].products).must_equal products
      expect(all_orders_32[0].customer).must_be_kind_of Customer
      expect(all_orders_32[0].customer.id).must_equal customer_id
      expect(all_orders_32[0].fulfillment_status).must_equal fulfill
    end

    it "returns empty array when customer id is not found amongst existing orders" do
      # Arrange and Act
      all_orders_50 = Order.find_by_customer(50)

      # Assert
      expect(all_orders_50.length).must_equal 0 # empty
      expect(all_orders_50).must_be_instance_of Array # check if it's array
    end
  end
end
