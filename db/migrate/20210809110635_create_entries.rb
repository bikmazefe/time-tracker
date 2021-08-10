class CreateEntries < ActiveRecord::Migration[6.0]
  def change
    create_table :entries, id: :uuid do |t|
      t.string :comment
      t.string :entry_type
      t.datetime :started_at
      t.datetime :finished_at
      t.belongs_to :user
      t.timestamps
    end
  end
end
