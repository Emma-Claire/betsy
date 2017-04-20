class AddPaymentInfoColumns < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :email, :string
    add_column :orders, :mailing_address, :string
    add_column :orders, :name_on_cc, :string
    add_column :orders, :cc_num, :integer
    add_column :orders, :cc_exp, :string
    add_column :orders, :cc_csv, :integer
    add_column :orders, :zip_code, :integer
  end
end
