module BookKeeping
  VERSION = 3
end

class School

  def initialize
    @roster = Hash.new { |hash,key| hash[key] = [] }
  end

  def students(grade)
    @roster[grade]
  end

  def students_by_grade
    @roster.sort.map { |grade,students| {grade: grade, students: students} }
  end

  def add(name, grade)
    @roster[grade] << name
    @roster[grade].sort!
  end

end
