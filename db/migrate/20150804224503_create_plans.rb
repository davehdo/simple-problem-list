class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.text :history
      t.text :content

      t.timestamps null: false
    end
  end
end
