require "./lib/job_recommendation_service"

RSpec.describe JobRecommendationService do
  it "recommends jobs for a user corresponding to his skills" do
    expected_job_recommendations =
      [[
        {job_seeker_id: 1, jobseeker_name: "Alice Seeker", job_id: 1, job_title: "Ruby Developer", matching_skill_count: 3, matching_skills_percentage: 100.0},
        {job_seeker_id: 1, jobseeker_name: "Alice Seeker", job_id: 3, job_title: "Backend Developer", matching_skill_count: 2, matching_skills_percentage: 50.0},
        {job_seeker_id: 1, jobseeker_name: "Alice Seeker", job_id: 9, job_title: "Python Developer", matching_skill_count: 2, matching_skills_percentage: 50.0},
        {job_seeker_id: 1, jobseeker_name: "Alice Seeker", job_id: 7, job_title: "Data Analyst", matching_skill_count: 1, matching_skills_percentage: 25.0},
        {job_seeker_id: 1, jobseeker_name: "Alice Seeker", job_id: 4, job_title: "Fullstack Developer", matching_skill_count: 1, matching_skills_percentage: 16.666666666666664}
      ]]
    job_recommendations = JobRecommendationService.execute(["./data/test/jobseeker.csv", "./data/test/jobs.csv"])
    expect(job_recommendations).to eq(expected_job_recommendations)
  end

  it "returns job recommendations sorted by jobseeker ID" do
    job_recommendations = JobRecommendationService.execute(["./data/test/jobseekers.csv", "./data/test/jobs.csv"])
    expect(job_recommendations[0][0][:job_seeker_id]).to be < (job_recommendations[1][0][:job_seeker_id])
  end

  it "sorts jobs based on percentage of skills match" do
    job_recommendations = JobRecommendationService.execute(["./data/test/jobseeker.csv", "./data/test/jobs.csv"])
    expect(job_recommendations[0][0][:matching_skills_percentage]).to be > (job_recommendations[0][1][:matching_skills_percentage])
  end

  it "sorts jobs based on job_id when 2 roles have same matching_skills_percentage" do
    job_recommendations = JobRecommendationService.execute(["./data/test/jobseeker.csv", "./data/test/jobs_with_similar_skills.csv"])
    job_1_with_50_percent_skills_match = {job_seeker_id: 1, jobseeker_name: "Alice Seeker", job_id: 1, job_title: "Backend Developer", matching_skill_count: 2, matching_skills_percentage: 50.0}
    job_2_with_50_percent_skills_match = {job_seeker_id: 1, jobseeker_name: "Alice Seeker", job_id: 2, job_title: "Python Developer", matching_skill_count: 2, matching_skills_percentage: 50.0}
    expect(job_recommendations[0][0]).to eq(job_1_with_50_percent_skills_match)
    expect(job_recommendations[0][1]).to eq(job_2_with_50_percent_skills_match)
  end
end
