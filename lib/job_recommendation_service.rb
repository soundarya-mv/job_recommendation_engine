# frozen_string_literal: true

require_relative "../services/recommend_jobs"
require_relative "../services/parse_job_seekers_csv"
require_relative "../services/parse_jobs_csv"

class JobRecommendationService
  BATCH_SIZE = 10
  def self.execute(args)
    job_seekers = ParseJobSeekersCsv.execute(args[0])
    jobs = ParseJobsCsv.execute(args[1])
    job_recommender = RecommendJobs.new(jobs)
    job_recommendations_array = []
    job_seekers.each_slice(BATCH_SIZE) do |batch|
      batch.each do |job_seeker|
        job_recommendations = job_recommender.execute(job_seeker)
        job_recommendations_array << job_recommendations
      end
    end
    job_recommendations_array
  end
end
