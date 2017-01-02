class CreateFollows < ActiveRecord::Migration
  def change
    create_table :follows do |t|
      t.integer :follower_id,index:true
      t.integer :following_id,index:true

      t.timestamps null: false
    end
  end
end
