class RubyController < ApplicationController
  def velocity
  end

  def backlog
    @oct = Issue.ruby.where('issue_created_at < ? and (resolved_at is null or resolved_at between ? and ?)',
        Date.new(2019, 10, 1),
        Date.new(2019, 10, 1),
        Date.new(2019, 11, 1))
    @nov = Issue.ruby.where('issue_created_at < ? and (resolved_at is null or resolved_at between ? and ?)',
        Date.new(2019, 11, 1),
        Date.new(2019, 11, 1),
        Date.new(2019, 12, 1))
    @dec = Issue.ruby.where('issue_created_at < ? and (resolved_at is null or resolved_at between ? and ?)',
        Date.new(2019, 12, 1),
        Date.new(2019, 12, 1),
        Date.new(2020, 1, 1))
    @jan = Issue.ruby.where('issue_created_at < ? and (resolved_at is null or resolved_at between ? and ?)',
        Date.new(2020, 1, 1),
        Date.new(2020, 1, 1),
        Date.new(2020, 12, 1))
  end

  def origins
    @origins = %w[Engineering Support Product Labs]
    @origins << nil

    @created = Issue.ruby.tracked.q4(:issue_created_at)
    @created_origins = @origins.map {|to| @created.ticket_origin(to) }

    @resolved = Issue.ruby.tracked.q4(:resolved_at)
    @resolved_origins = @origins.map {|to| @resolved.ticket_origin(to) }
  end

  def defects
    @opened = Issue.ruby.bugs.q4(:issue_created_at)
    @closed = Issue.ruby.bugs.q4(:resolved_at)

    @opened_weeks = Issue.bin_into_weeks(
        Date.new(2019, 10, 1),
        @opened,
        :issue_created_at)

    @closed_weeks = Issue.bin_into_weeks(
        Date.new(2019, 10, 1),
        @closed,
        :resolved_at)

    @weeks = @opened_weeks.length > @closed_weeks.length ?
        @opened_weeks.map(&:key) :
        @closed_weeks.map(&:key)
  end

  def unplanned
  end
end
