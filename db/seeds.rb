if User.exists?(1)
  puts "Data already exists. Skipping seed file."
  exit
end

admin    = Admin.create!({email: "admin@gmail.com",
                          password: "12345678",
                          password_confirmation: "12345678",
                          first_name: "Principal",
                          last_name: "Larry"
                        })

teacher  = Teacher.create!({email: "teacher@gmail.com",
                            password: "12345678",
                            password_confirmation: "12345678",
                            first_name: "Samwise",
                            last_name: "Gamgee"
                           })

teacher2 = Teacher.create!({email: "teacher2@gmail.com",
                            password: "12345678",
                            password_confirmation: "12345678",
                            first_name: "Gandalf",
                            last_name: "The Grey"
                           })

student  = Student.create!({email: "student@gmail.com",
                            password: "12345678",
                            password_confirmation: "12345678",
                            first_name: "Frodo",
                            last_name: "Bagins"
                           })

60.times do
  Student.create!({email: (0...8).map { (65 + rand(26)).chr }.join + "@gmail.com",
                   password: "12345678",
                   password_confirmation: "12345678",
                   first_name: Faker::Name.first_name,
                   last_name: Faker::Name.last_name
                  })
end

month_count = 15
5.times do
  Semester.create!({begin_date: Date.today - month_count.months,
                    end_date: Date.today - ((month_count - 3).months)
                  })
  month_count = month_count - 3
end

15.times do
  Course.create!({name: Faker::Company.catch_phrase,
                  description: Faker::Company.bs,
                  teacher_id: Teacher.limit(1).order("RANDOM()").first.id,
                  semester_id: Semester.limit(1).order("RANDOM()").first.id
                })
end

Student.all.each do |s|
  StudentCourse.create!(student_id: s.id,
                        course_id: Course.limit(1).order("RANDOM()").first.id,
                        grade: [0,1,2,3,4].sample)
end
