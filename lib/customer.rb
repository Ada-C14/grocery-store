#WAVE 1 --> Create a class called Customer
require 'csv'

class Customer
  #ID is readable
  attr_reader :id
  #Email/Address are writable
  attr_accessor :email, :address

  #define method constructor
  def initialize(id, email, address)
    @id = id
    @email = email
    @address = address
  end

  def self.all



  end