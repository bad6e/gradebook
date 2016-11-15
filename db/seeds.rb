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

3.times do
  Semester.create!({begin_date: Date.today,
                    end_date: Date.today + 3.months
                  })
end

10.times do
  Course.create!({name: Faker::Company.catch_phrase,
                  description: Faker::Company.bs,
                  teacher_id: Teacher.limit(1).order("RANDOM()").first.id,
                  semester_id: Semester.limit(1).order("RANDOM()").first.id
                })
end