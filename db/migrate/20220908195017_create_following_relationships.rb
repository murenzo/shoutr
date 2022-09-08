class CreateFollowingRelationships < ActiveRecord::Migration[5.0]
  def change
    create_table :following_relationships do |t|
      t.references :follower, references: :users, foreign_key: { to_table: :users }, null: false
      t.references :followed_user, references: :users, foreign_key: { to_table: :users }, null: false

      t.timestamps
    end
  end
end
