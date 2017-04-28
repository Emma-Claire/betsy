require 'test_helper'

describe "Order" do
  let(:pending) { Order.create(status: "pending", email: "string",
    mailing_address: "string", name_on_cc: "st", cc_num: 7171, cc_exp: 7171,
    cc_csv: 818, zip_code: 81818) }
  let(:blank_order) { Order.create(status: " ",  email: " ", mailing_address: " ",
    name_on_cc: " ", cc_num: " ", cc_exp: " ", cc_csv: " ", zip_code: " ") }
  let(:bad_status) { Order.create(status: "Lau", email: "string",
    mailing_address: "string", name_on_cc: "string", cc_num: 7171, cc_exp: 7171,
    cc_csv: 818, zip_code: 81818) }
  let(:bad_name_on_cc) { Order.create(status: "paid", email: "string",
    mailing_address: "string", name_on_cc: 989, cc_num: 7171, cc_exp: 7171,
    cc_csv: 818, zip_code: 81818) }
  let(:bad_cc_num) { Order.create(status: "paid", email: "string",
    mailing_address: "string", name_on_cc: "string", cc_num: 171, cc_exp: 7171,
    cc_csv: 818, zip_code: 81818) }
  let(:bad_cc_exp) { Order.create(status: "paid", email: "string",
    mailing_address: "string", name_on_cc: "string", cc_num: 1371, cc_exp: 717,
    cc_csv: 818, zip_code: 81818) }
  let(:bad_cc_csv) { Order.create(status: "paid", email: "string",
    mailing_address: "string", name_on_cc: "string", cc_num: 1371, cc_exp: 7127,
    cc_csv: "hello", zip_code: 81818) }
  let(:bad_zip_code) { Order.create(status: "paid", email: "string",
    mailing_address: "string", name_on_cc: "string", cc_num: 1371, cc_exp: 7127,
    cc_csv: 611, zip_code: "Cara") }


  describe "relationships" do
    it "one order has to have one or more orderedproducts" do
      pending.must_respond_to :orderedproducts
    end

    it "one order has to have one or more products" do
      pending.must_respond_to :products
    end
  end

  describe "Validations" do
    it "Do not let create a new order with a blank fields" do
      blank_order.valid?.must_equal false
    end

    it "pending posible status must be valid" do
      pending.must_be :valid?
    end

    it "Do not let create a new order without a right status" do
      bad_status.valid?.must_equal false
    end

    it "Do not let create a new order without a correct name_on_cc" do
      bad_name_on_cc.valid?.must_equal false
    end

    it "Do not let create a new order without a correct lenght for cc fields" do
      bad_cc_num.valid?.must_equal false
      bad_cc_exp.valid?.must_equal false
      bad_cc_csv.valid?.must_equal false
    end


    it "Do not let create a new order without a numeric zip code" do
      bad_zip_code.valid?.must_equal false
    end
  end

  # describe "methods" do
  #   describe "item_total" do
  #     it "" do
  #       o = Order.new(status: "pending", email: "string", mailing_address: "string",
  #         name_on_cc: "string", cc_num: 7171, cc_exp: 7171, cc_csv: 818, zip_code: 81818)
  #       op = Orderedproducts.new(quantity: 2, product_id: 2, order_id: 1, shipped: false)
  #
  #       assert_equal(2, o.orderedproducts.item_total)
  #
  #
  #     end
  #   end
  #
  # end
end
