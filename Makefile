run:
	bundle exec ruby lib/cli.rb ./data/development/jobseekers.csv ./data/development/jobs.csv

lint:
	bundle exec standardrb -a lib models services spec

test:
	bundle exec rspec
