class CreatePortfolios < ActiveRecord::Migration
  def change
    create_table :portfolios do |t|

    	      t.string :name
            t.string :description
            t.string :projectarea
            t.date   :start_date
            t.date   :end_date 

      t.timestamps null: false
    end
  end
end
