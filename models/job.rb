class Job
  attr_accessor :id, :title, :skills

  def initialize(id, title, skills)
    @id = id
    @title = title
    @skills = skills
  end
end
