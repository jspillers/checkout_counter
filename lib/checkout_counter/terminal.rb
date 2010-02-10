module CheckoutCounter
  class Terminal

    attr_reader :bulk_discount

    def initialize
      @scanned_products = []
      @bulk_discount = 0.0
    end

    def scan(product_code)
      @scanned_products << CheckoutCounter::Product.new(product_code)
    end

    def total
      total = 0.0
      @scanned_products.each do |product|
        total += product.price
      end
      
      @bulk_discount = bulk_discount(@scanned_products)

      # in a real application dealing with money I would
      # never use floats with currency... there are serious 
      # gotchas with using floats and currency - instead I would
      # probably use one of the purpose built money/currency 
      # libraries or use big decimal: 
      # (http://ruby-doc.org/stdlib/libdoc/bigdecimal/rdoc/index.html)
      sprintf("%.2f", total - @bulk_discount)
    end

    private

    def bulk_discount(products)
      discount = 0.0
      prod_codes = products.map{|p| p.product_code }

      CheckoutCounter::Product.bulk_deals.each do |bulk_deal|
        discount += bulk_deal.call(prod_codes)
      end

      discount
    end
  end
end
