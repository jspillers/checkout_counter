require File.join(File.dirname(__FILE__),'checkout_counter','terminal')
require File.join(File.dirname(__FILE__),'checkout_counter','product')

module CheckoutCounter
  class InvalidProductCodeError < StandardError; end; 
end

# for example usage and proof of meeting the calculation requirements please see
# and run the spec in the spec directory
