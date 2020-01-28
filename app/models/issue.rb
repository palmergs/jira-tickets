# frozen_string_literal: true

require 'csv'

class Issue < ApplicationRecord
  class Bin
    attr_reader :key, :values

    def initialize key, values = []
      @key = key
      @values = values
    end

    def [] idx
      return key if idx == 0
      return values if idx == 1
      raise ArgumentError, 'index out of bounds'
    end

    def << val
      @values << val if val
    end

    def categories field, numeric_field = nil, include_empty = false
      Issue.category_count(values, field, numeric_field, include_empty)
    end
  end

  has_many :issue_components
  has_many :issue_labels
  has_many :issue_sprints

  scope :sup, -> { where(project: 'SUP') }
  scope :ruby, -> { where(project: 'RUBY') }
  scope :python, -> { where(project: 'PYT') }
  scope :go, -> { where(project: ['SPEED', 'GO']) }
  scope :speed, -> { where(project: 'SPEED') }
  scope :goagent, -> { where(project: 'GO') }
  scope :tandv, -> { where(project: 'TV') }

  scope :bugs, -> { where(issue_type: 'Bug') }
  scope :stories, -> { where(issue_type: 'Story') }
  scope :tasks, -> { where(issue_type: 'Task') }

  scope :with_component, ->(components) {
    joins(:issue_components).where(issue_components: { name: Array(components) })
  }

  scope :with_label, ->(labels) {
    joins(:issue_labels).where(issue_labels: { name: Array(labels) })
  }

  scope :q1, ->(field = :issue_created_at, year = 2020) {
    st = Date.new(year, 1, 1)
    en = st + 3.months
    where(field.to_sym => st..en)
  }

  scope :q2, ->(field = :issue_created_at, year = 2020) {
    st = Date.new(year, 3, 1)
    en = st + 3.months
    where(field.to_sym => st..en)
  }

  scope :q3, ->(field = :issue_created_at, year = 2020) {
    st = Date.new(year, 6, 1)
    en = st + 3.months
    where(field.to_sym => st..en)
  }

  scope :q4, ->(field = :issue_created_at, year = 2019) { 
    st = Date.new(year, 10, 01)
    en = st + 3.months
    where(field.to_sym => st..en)
  }

  scope :issue_types, -> {
    where('issue_type is not null').group(:issue_type)
  }

  scope :priorities, -> {
    where('priority is not null').group(:priority)
  }

  scope :ticket_origins, -> {
    group(:ticket_origin)
  }

  scope :origins, -> {
    group(:origin)
  }

  scope :product_components, -> {
    group(:product_component)
  }

  def incr numeric_field = nil
    numeric_field ? self[numeric_field.to_sym].to_i : 1
  end

  def self.sum values
    return 0 if values.empty?

    values.map(&:to_f).inject(&:+)
  end

  def self.mean values
    return 0 if values.empty?

    sum(values) / values.length.to_f
  end

  def self.median values
    return 0 if values.empty?

    sorted = values.sort
    if sorted.length % 2 == 0
      (sorted[sorted.length / 2] + sorted[sorted.length / 2 + 1]) / 2.0
    else
      sorted[sorted.length / 2]
    end
  end

  def self.sample_variance values
    return 0 if values.empty?

    m = mean(values)
    sum = values.inject(0) {|accum, i| accum + (i-mean)**2 }
    sum / (values.length - 1).to_f
  end

  def std_dev values
    return 0 if values.empty?

    var = sample_variance(values)
    Math.sqrt(var)
  end

  # Brute force move issues into an array element corresponding 
  # to the week when it occurred.
  def self.bin_into_weeks start_dt, issues, field
    last_dt = start_dt + 7.days
    arr = [Bin.new(start_dt)]
    issues.each do |issue|
      dt = issue[field]
      next unless dt
      next if dt < start_dt

      while dt > last_dt
        arr << Bin.new(last_dt)
        last_dt = last_dt + 7.days
      end

      idx = (dt.to_date - start_dt.to_date).to_i / 7
      arr[idx] << issue
    end

    arr
  end

  def self.map_to_count issues, field = nil
    return issues.count unless field
    return 0 if issues.empty?
    
    issues.inject(0) {|sum, issue| sum + issue[field].to_i }
  end

  def self.category_count issues, field, numeric_field = nil, include_empty: false
    raise ArgumentError, 'field must be defined' unless field

    hsh = Hash.new {|h,v| h[v] = 0}
    issues.each do |issue|
      val = issue[field.to_sym]
      next unless val || include_empty

      incr = issue.incr(numeric_field)
      hsh[val] += incr
    end
    hsh
  end

  def self.to_csv
    attributes = %i{project issue_type issue_id story_points summary status resolution issue_created_at resolved_at priority ticket_origin origin product_component}

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |issue|
        csv << attributes.map{ |attr| issue[attr] }
      end
    end
  end
end
