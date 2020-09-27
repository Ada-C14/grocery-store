class Order
  attr_reader :id
  attr_accessor :products_prices

  def initialize(id, products_prices, customer, fulfilment_status)
    @id = id
    @products_prices = products_prices
      #{ "banana" => 1.99, "cracker" => 3.00 }
      # Zero products is permitted (an empty hash)
      # You can assume that there is only one of each product
    @customer = customer
    @fulfilment_status = fulfilment_status
      #:pending, :paid, :processing, :shipped, or :complete
      # If no fulfillment_status is provided, it will default to :pending
      # If a status is given that is not one of the above, an ArgumentError should be raised
  end


  #  A total method which will calculate the total cost of the order by:
    # Summing up the products
    # Adding a 7.5% tax
    # Rounding the result to two decimal places


  # An add_product method which will take in two parameters, product name and price, and add the data to the product collection
   # If a product with the same name has already been added to the order, an ArgumentError should be raised


  #  Optional Enhancements
    # Make sure to write tests for any optionals you implement!
    # Add a remove_product method to the Order class which will take in one parameter, a product name, and remove the product from the collection
      # If no product with that name was found, an ArgumentError should be raised
end