class CreateCreditCards < ActiveRecord::Migration
  def change
    create_table :credit_cards do |t|
      t.belongs_to :customer, index: true
      t.string :card_number
      t.date :expires_on

      t.timestamps
    end
  end
end
