module CheckoutCounter
  class Product

    attr_reader :product_code

    def initialize(prod_code)
      self.product_code = prod_code
    end

    # in the real world this information would almost
    # certainly come from some kind of data store such 
    # as mysql/activerecord and would probably want to 
    # tie a checkout counter instance to a product via
    # some sort of join object/table
    PRODUCTS = { 
      "A" => 2.00, 
      "B" => 12.00, 
      "C" => 1.25,
      "D" => 0.15
    }

    # returns an array of lambdas which are responsible for
    # detecting the presence of bulk discount combinations
    # when one or more groupings is found in the array of product
    # codes passed into the closure the appropriate discount is returned
    # 
    # using lambdas instead of procs because lambdas care
    # about arity and will complain bitterly if not satisfied
    def self.bulk_deals
      [
        lambda do |prod_codes|
          possible_bulk_combos = prod_codes.select { |p| p == "A" }
          (possible_bulk_combos.size / 4) * 1.00
        end,

        lambda do |prod_codes|
          possible_bulk_combos = prod_codes.select { |p| p == "C" }
          (possible_bulk_combos.size / 6) * 1.50
        end
      ]
    end

    def product_code=(prod_code)
      if PRODUCTS.keys.include?(prod_code)
        @product_code = prod_code 
      else
        raise InvalidProductCodeError
      end
    end

    def price
      PRODUCTS[@product_code]
    end

  end
end
