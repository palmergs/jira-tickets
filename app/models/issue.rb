class Issue < ApplicationRecord
  has_many :issue_components
  has_many :issue_labels
  has_many :issue_sprints
end
