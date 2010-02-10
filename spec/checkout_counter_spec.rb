require File.expand_path(File.join(File.dirname(__FILE__),'..','lib','checkout_counter'))

describe CheckoutCounter::Terminal do

  describe "a new instance" do
    before do
      @it = CheckoutCounter::Terminal.new
    end

    it "should be a valid object" do
      @it.is_a?(CheckoutCounter::Terminal).should be_true
    end

    it "should return zero when no products have been scanned" do
      @it.total.should == "0.00" 
    end

    it "should raise an error when passed an invalid product code" do
      lambda { @it.scan("X") }.should raise_error CheckoutCounter::InvalidProductCodeError
    end

    it "should return the correct total for A" do
      @it.scan("A")
      @it.total.should == "2.00"
    end

    it "should return the correct total for B" do
      @it.scan("B")
      @it.total.should == "12.00"
    end

    it "should return the correct total for C" do
      @it.scan("C")
      @it.total.should == "1.25"
    end

    it "should return the correct total for D" do
      @it.scan("D")
      @it.total.should == "0.15"
    end

    describe "when products ABCDABAA are scanned" do
      before do
        "ABCDABAA".split("").each do |product_code|
          @it.scan(product_code)  
        end
      end

      it "#total should return the correct total" do
        @it.total.should == "32.40"
      end
    end

    describe "when products ABCDABAAABCDABAA are scanned" do
      before do
        "ABCDABAAABCDABAA".split("").each do |product_code|
          @it.scan(product_code)  
        end
      end

      it "#total should return the correct total" do
        @it.total.should == "64.80"
      end
    end

    describe "when products CCCCCCC are scanned" do
      before do
        "CCCCCCC".split("").each do |product_code|
          @it.scan(product_code)  
        end
      end

      it "#total should return the correct total" do
        @it.total.should == "7.25"
      end
    end

    describe "when products ABCD are scanned" do
      before do
        "ABCD".split("").each do |product_code|
          @it.scan(product_code)  
        end
      end

      it "#total should return the correct total" do
        @it.total.should == "15.40"
      end
    end

  end
end
