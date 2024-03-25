# frozen_string_literal: true

class RecommendJobs
  BATCH_SIZE = 10
  attr_accessor :jobs

  def initialize(jobs)
    @jobs = jobs
  end

  def execute(job_seeker)
    job_matches = []
    @jobs.each_slice(BATCH_SIZE) do |batch|
      batch.each do |job|
        matching_skills_count = (job_seeker.skills & job.skills).count
        # Fuzzy match can be used to match the skills that are represented in different ways. Ex: React, React.js
        # Skill abbrevation mapping hash can be used and skills can be normalized while matching for skills that can be used both in abbreviated and full forms - Eg: { CSS: Cascading Style Sheets }
        matching_skills_percentage = (matching_skills_count.to_f / job.skills.count) * 100
        next if matching_skills_count == 0
        job_match = {
          job_seeker_id: job_seeker.id,
          jobseeker_name: job_seeker.name,
          job_id: job.id,
          job_title: job.title,
          matching_skill_count: matching_skills_count,
          matching_skills_percentage: matching_skills_percentage
        }
        job_matches << job_match
      end
    end
    job_matches.sort_by { |job_match| [-(job_match[:matching_skills_percentage]), job_match[:job_id]] }
  end
end
