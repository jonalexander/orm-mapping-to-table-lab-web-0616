class Student
  attr_accessor :name, :grade
  attr_reader :id

  def initialize(name, grade)
    @name = name
    @grade = grade
    @id = nil
  end

  def self.create_table
    sql_code = <<-SQL
    CREATE TABLE IF NOT EXISTS students (
      id INTEGER PRIMARY KEY,
      name TEXT,
      grade INTEGER
    )
    SQL

    DB[:conn].execute(sql_code)
  end

  def self.drop_table
    sql_code = "DROP TABLE students"
    DB[:conn].execute(sql_code)
  end

  def save
    sql_code = "INSERT INTO students (name, grade) VALUES (?, ?);"
    DB[:conn].execute(sql_code, self.name, self.grade)
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
  end

  def self.create(name:, grade:)
    student = self.new(name, grade)
    student.save
    student
  end
end
