class IssuesController < ApplicationController
  def index
    @query = Issue.all
    respond_to do |format|
      format.html
      format.text { render plain: @query.to_csv, content_type: 'text/plain' }
      format.csv { render plain: @query.to_csv, content_type: 'text/csv' }
    end
  end

  def show

  end
end
