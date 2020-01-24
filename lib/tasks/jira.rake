require 'csv'
require_relative '../csv_to_issue'

namespace :jira do
  desc "load a CSV of jira issues into database"
  task :load_file, [:path] => [:environment] do |t, args|
    path = args.path
    puts "path=#{ path }"
    
    rows = CSV.read(path)
    header = rows[0]

    mapper = CsvToIssue.new
    mapping = mapper.header_to_mappings(header)

    rows.each_with_index do |row, rown|
      next if rown == 0

      begin
        coln = 0
        issue = Issue.new
        row.each_with_index do |col, coln|
          handler = mapping[coln]
          handler.call(issue, col) if handler
        end
        issue.save!
      rescue => e
        puts "could not parse #{ rown },#{ coln }: #{ e }"
      end
    end
  end
end
