# frozen_string_literal: true

require 'csv'

class CsvToIssue
  def header_to_mappings header
    mapping = {}
    header.each_with_index do |heading, idx|
      handler = mapping(heading)
      mapping[idx] = handler unless handler.nil?
    end 
    mapping
  end

  # 
  # Issue Type
  # Issue key
  # Issue id
  # Epic key
  # Summary
  # Assignee
  # Status
  # Updated
  # Components
  # Components
  # Components
  # Custom field (Story Points)
  # Created
  # Priority
  # Custom field (Ticket Origin)
  # Custom field (Ticket Origin)
  # Custom field (Origin)
  # Custom field (Product Component)
  # Resolution
  # Resolved
  # Project key
  # Project name
  # Project type
  # Project lead
  # Project description
  # Project url
  # Fix version
  # Sprint
  # Labels
  def mapping heading
    return if heading.blank?

    case heading
    when /Issue Type/i
      -> (m, v) { m.issue_type = v unless v.blank? }
    when /Issue key/i
      -> (m, v) { m.issue_key = v unless v.blank? }
    when /Issue id/i
      -> (m, v) { 
        m.issue_id = v.to_i
        m.save
      }
    when /Summary/i
      -> (m, v) { m.summary = v.to_s }
    when /Assignee/i
      -> (m, v) { m.assignee = v.to_s }
    when /^Status/i
      -> (m, v) { m.status = v unless v.blank? }
    when /^Updated/i
      -> (m, v) { m.issue_updated_at = jira_date(v) unless v.blank? }
    when /Components/i
      -> (m, v) { m.issue_components.build(name: v) unless v.blank? }
    when /\(Story Points\)/i
      -> (m, v) { m.story_points = v.to_i }
    when /\(Epic Link\)/i
      -> (m, v) { m.epic_key = v unless v.blank? }
    when /^Created/i
      -> (m, v) { m.issue_created_at = jira_date(v) unless v.blank? }
    when /^Priority/i
      -> (m, v) { m.priority = v unless v.blank? }
    when /\(Ticket Origin\)/i
      -> (m, v) { m.ticket_origin = v unless v.blank? }
    when /\(Origin\)/i
      -> (m, v) { m.origin = v unless v.blank? }
    when /\(Product Component\)/i
      -> (m, v) { m.product_component = v unless v.blank? }
    when /Resolution/i
      -> (m, v) { m.resolution = v unless v.blank? }
    when /^Resolved/i
      -> (m, v) { m.resolved_at = jira_date(v) unless v.blank? }
    when /Project key/i
      -> (m, v) { m.project = v unless v.blank? }
    when /Project name/i
      -> (m, v) { m.project_name = v unless v.blank? }
    when /^Labels/i
      -> (m, v) { m.issue_labels.build(name: v) unless v.blank? }
    when /^Sprint/i
      ->(m, v) { m.issue_sprints.build(name: v) unless v.blank? }
    when /^Fix versions/i
      ->(m, v) { m.fix_version = v unless v.blank? }
    end
  end

  # format = '%d/%b/%y %l:%M %p'
  # 22/Jan/20 12:47 PM
  def jira_date str
    DateTime.parse(str)
  rescue => e
    puts "Can not parse #{ str }: #{ e }"
    nil
  end
end
