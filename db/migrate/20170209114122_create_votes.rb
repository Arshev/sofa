class CreateVotes < ActiveRecord::Migration[5.0]
  def change
    create_table :votes do |t|
      t.integer :value, default: 0
      t.string  :votable_type
      t.belongs_to :user
      t.references :votable, polymorphic: true, index: true
      t.timestamps
    end
    add_index :votes, [:votable_id, :votable_type, :user_id], unique: true
    add_index :votes, [:votable_id, :votable_type]
  end
end
