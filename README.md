Use make run to execute the cli with the default development data. There is a data/ directory with sample data.

	make run
	bundle exec ruby lib/cli.rb ./data/development/jobseekers.csv ./data/development/jobs.csv


Use make test to run all tests.

	make test
	bundle exec rspec


Use make lint to check code for style issues.

	make lint
	bundle exec standardrb -a lib models services spec


How business logics are separated from main file:

	Separate service objects for parsing JobSeekers and Jobs CSV's to have more maintainability.
 
	Have added separate models for jobseekers and jobs to have more clarity on the data that the 2 modules will hold and can be extended when ORM is used to store the data in database.
 
	Since recommendation of jobs is a commonly used method, have added separate service object for that as well and can be reused in other parts of the application.

How models have been defined:

	JobSeeker model, holds the job_seeker_id, job_seeker_name, job_seeker_skills
 
	Job model, holds the job_id, job_title, required_skills

Addtional information:

	Have used array structure to hold the job_seeker and job details in memory to keep it simple as the requirement was to load data from CSV, recommend jobs for each job_seeker.
 
	If we are using a database like MySQL, PostgreSQL to store the job_seeker and job details, active record save/create can be used.
