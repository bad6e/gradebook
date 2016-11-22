require 'rails_helper'

feature 'Student can see statistics' do
  given!(:teacher)   { create(:teacher) }
  given!(:semester1) { create(:semester) }
  given!(:semester2) { create(:semester) }
  given!(:semester2) { create(:semester) }
  given!(:student1)  { create(:student) }
  given!(:student2)  { create(:student) }

  given!(:course1) { create(:course,
                            semester_id: semester1.id,
                            teacher_id: teacher.id)
  }

  given!(:course2) { create(:course,
                            semester_id: semester1.id,
                            teacher_id: teacher.id)
  }

  given!(:course3) { create(:course,
                            semester_id: semester2.id,
                            teacher_id: teacher.id)
  }

  given!(:student_course1) { create(:student_course,
                                    student_id: student1.id,
                                    course_id: course1.id,
                                    grade: 0.0)
  }

  given!(:student_course2) { create(:student_course,
                                    student_id: student1.id,
                                    course_id: course2.id,
                                    grade: 4.0)
  }

  given!(:student_course3) { create(:student_course,
                                    student_id: student1.id,
                                    course_id: course3.id,
                                    grade: 3.0)
  }

  scenario 'student can select a semester and see their semester grade and all the courses they took for that semester', js: true do
    log_in_as(student1)

    within('.student-semester-list') do
      select("#{semester1.begin_date} to #{semester1.end_date}",
             from: 'semesters-select')

      expect(page).to have_content(course1.name)
      expect(page).to have_content(course2.name)
      expect(page).to have_content(2.0)

      select("#{semester2.begin_date} to #{semester2.end_date}",
             from: 'semesters-select')

      expect(page).to have_content(course3.name)
      expect(page).to have_content(3.0)
    end
  end

  scenario 'a student can select a course from a semester and see the course description and their name and their grade for that course', js: true do
    log_in_as(student1)

    within('.student-semester-list') do
      select("#{semester1.begin_date} to #{semester1.end_date}",
             from: 'semesters-select')

      expect(page).to have_content(course1.name)

      click_on(course1.name)

      expect(page).to have_content(student1.full_name)

      student_1_grade = StudentCourse.where(student_id: student1.id,
                                            course_id: course1.id).first

      expect(page).to have_content(student_1_grade.grade)
    end
  end
end
