class IssuesController < ApplicationController
  COLS_TO_HEADERS = {
    project: 'Project',
    priority: 'Priority',
    issue_type: 'Type',
    issue_key: 'Key',
    epic_key: 'Epic',
    story_points: 'Points',
    status: 'Status',
    resolution: 'Resolution',
    issue_created_at: 'Created',
    resolved_at: 'Resolved',
    ticket_origin: 'Ticket Origin',
    product_component: 'Product Component'}.freeze

  def index
    @query = Issue.includes(:issue_labels, :issue_components).all
    @issues = @query.limit(100)
    respond_to do |format|
      format.html
      format.text { render plain: @query.to_csv, content_type: 'text/plain' }
      format.csv { render plain: @query.to_csv, content_type: 'text/csv' }
    end
  end

  def show
    @issue = Issue.find(params[:id])
    respond_to do |format|
      format.html
      format.text { render plain: @issue.to_csv, content_type: 'text/plain' }
      format.csv { render plain: @issue.to_csv, content_type: 'text/csv' }
    end
  end
end
