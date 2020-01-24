class CreateIssues < ActiveRecord::Migration[6.0]
  def change
    create_table :issues do |t|
      t.string :project, limit: 10, index: true
      t.string :project_name, limit: 30
      t.string :issue_type, limit: 20, index: true
      t.string :issue_key, limit: 30, index: true
      t.bigint :issue_id, null: false
      t.integer :story_points, null: false, default: 0
      t.string :summary
      t.string :assignee
      t.string :status, limit: 30, index: true
      t.string :resolution, limit: 30, index: true
      t.string :fix_version, limit: 100
      t.datetime :issue_updated_at, index: true
      t.datetime :issue_created_at, index: true
      t.datetime :resolved_at, index: true
      t.string :priority, limit: 30, index: true
      t.string :ticket_origin, limit: 30, index: true
      t.string :origin, limit: 30, index: true
      t.string :product_component, limit: 30, ndex: true

      t.timestamps
    end

    add_index :issues, :issue_id, unique: true
  end
end
