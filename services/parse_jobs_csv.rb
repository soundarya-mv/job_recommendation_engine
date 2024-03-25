require "csv"
require_relative "../models/job"
class ParseJobsCsv
  def self.execute(file_path)
    jobs = []
    CSV.foreach(file_path, headers: true) do |row|
      # Have added a separate model for Account to have more clarity on how accounts will look like
      # And in future if we are using any ORM to save the data in database, we can use the same model.
      job = Job.new(row["id"].to_i, row["title"], row["required_skills"].split(","))
      jobs << job
    end
    jobs
  end
end
