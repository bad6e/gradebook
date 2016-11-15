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