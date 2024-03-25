require "csv"
require_relative "../models/job_seeker"
class ParseJobSeekersCsv
  def self.execute(file_path)
    job_seekers = []
    CSV.foreach(file_path, headers: true) do |row|
      # Have added a separate model for Account to have more clarity on how accounts will look like
      # And in future if we are using any ORM to save the data in database, we can use the same model.
      job_seeker = JobSeeker.new(row["id"].to_i, row["name"], row["skills"].split(","))
      job_seekers << job_seeker
    end
    job_seekers
  end
end
