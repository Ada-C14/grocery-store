class Order
  def initialize (id, products, customer, fulfillment_status = :pending)
    @id = id #number
    @products = products #hash, will figure this out later
    @customer = customer #string?
    @fulfillment_status = fulfillment_status
      status_options = [:pending, :paid, :processing, :shipped, :complete]
      if status_options.include? fulfillment_status
        @fulfillment_status = fulfillment_status
      else
        raise ArgumentError
      end #symbol with qualifications, should method be here?
  end

  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status

  def status_update (fulfillment_status)
    status_options = [:pending, :paid, :processing, :shipped, :complete]
    if status_options.include? @fulfillment_status
      @fulfillment_status = fulfillment_status
    else
      raise ArgumentError
    end
  end



  def total
    sum = 0.00
    @products.each do |product, cost|
      sum += cost
    end

    sum *= 1.075

    total = '%.2f' % sum

    return  total.to_f
  end

  def add_product(name, price)
    if @products.include? name
      raise ArgumentError
    else @products[name] = price
    end

  end

end