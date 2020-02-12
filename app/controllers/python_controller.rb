class PythonController < ApplicationController
  def velocity

  end

  def backlog
    params[:q] ||= (Time.now.month - 3) < 0 ? 4 : ((Time.now.month - 3 % 4) + 1)
    params[:y] ||= (params[:q] == 4 ? Time.now.year - 1 : Time.now.year)
    params[:p] ||= 'Python'
    params[:t] ||= 'Tracked'

    year = params[:y].to_i
    quarter = params[:q].to_i
    month = Date.new(year, (quarter - 1) * 3 + 1, 1)

    @months = {}
    4.times do
      next_month = month + 1.month
      @summary = Issue.project(params[:p]).
          tickets(params[:t]).
          where('issue_created_at < ? and (resolved_at is null or resolved_at between ? and ?)', month, month, next_month)
      @months[month] = @summary
      month = next_month
    end
  end

  def origins
    params[:q] ||= (Time.now.month - 3) < 0 ? 4 : ((Time.now.month - 3 % 4) + 1)
    params[:y] ||= (params[:q] == 4 ? Time.now.year - 1 : Time.now.year)
    params[:p] ||= 'Python'
    params[:t] ||= 'Tracked'

    @origins = %w[Engineering Support Product Labs]
    @origins << nil

    @created = Issue.project(params[:p]).
          tickets(params[:t]).
          q(params[:q].to_i, params[:y].to_i, :issue_created_at)
    @created_origins = @origins.map {|to| @created.ticket_origin(to) }

    @resolved = Issue.project(params[:p]).
        tickets(params[:t]).
        q(params[:q].to_i, params[:y].to_i, :resolved_at)
    @resolved_origins = @origins.map {|to| @resolved.ticket_origin(to) }


    @created_sprints = Issue.bin_into_sprints(
        params[:y].to_i,
        params[:q].to_i,
        @created,
        :issue_created_at)
    @resolved_sprints = Issue.bin_into_sprints(
        params[:y].to_i,
        params[:q].to_i,
        @resolved,
        :resolved_at)
  end

  def defects
    params[:q] ||= (Time.now.month - 3) < 0 ? 4 : ((Time.now.month - 3 % 4) + 1)
    params[:y] ||= (params[:q] == 4 ? Time.now.year - 1 : Time.now.year)
    params[:p] ||= 'Python'
    params[:t] ||= 'Bug'

    @opened = Issue.project(params[:p]).
        tickets(params[:t]).
        q(params[:q].to_i, params[:y].to_i, :issue_created_at)
    @closed = Issue.project(params[:p]).
        tickets(params[:t]).
        q(params[:q].to_i, params[:y].to_i, :resolved_at)

    dt = Date.new(params[:y].to_i, (params[:q].to_i * 3) - 2, 1)
    @opened_weeks = Issue.bin_into_weeks(dt, @opened, :issue_created_at, pad_to: dt+3.months)
    @closed_weeks = Issue.bin_into_weeks(dt, @closed, :resolved_at, pad_to: dt+3.months)
  end

  def unplanned
    params[:q] ||= (Time.now.month - 3) < 0 ? 4 : ((Time.now.month - 3 % 4) + 1)
    params[:y] ||= (params[:q] == 4 ? Time.now.year - 1 : Time.now.year)
    params[:p] ||= 'Python'
    params[:t] ||= 'Tracked'

    @unplanned = Issue.project(params[:p]).
        tickets(params[:t]).
        q(params[:q].to_i, params[:y].to_i, :issue_created_at).
        where('resolved_at is not null').
        with_label(%w[unplanned Unplanned])
    @bins = [[], [], [], []]
    @unplanned.each do |u|
      days = (u.resolved_at.to_date - u.issue_created_at.to_date).to_i

      @bins[0] << u if days <= 7
      @bins[1] << u if days > 7 && days <= 14
      @bins[2] << u if days > 14 && days <= 30
      @bins[3] << u if days > 30
    end

    @unplanned_sprints = Issue.bin_into_sprints(
        params[:y].to_i,
        params[:q].to_i,
        @unplanned,
        :issue_created_at)
  end
end
