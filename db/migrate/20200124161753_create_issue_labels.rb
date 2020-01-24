class CreateIssueLabels < ActiveRecord::Migration[6.0]
  def change
    create_table :issue_labels do |t|
      t.belongs_to :issue, null: false, foreign_key: true
      t.string :name, limit: 200, null: false, index: true

      t.timestamps
    end
  end
end
