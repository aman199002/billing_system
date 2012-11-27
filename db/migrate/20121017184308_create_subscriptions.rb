class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.string :paypal_customer_token
      t.string :paypal_recurring_profile_token
      t.string :email

      t.timestamps
    end
  end
end
