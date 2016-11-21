require "rails_helper"

feature "Admin can see average course grade" do
  given!(:admin)     { create(:admin) }
  given!(:teacher)   { create(:teacher) }
  given!(:semester1) { create(:semester) }
  given!(:semester2) { create(:semester) }
  given!(:student1)  { create(:student) }
  given!(:student2)  { create(:student) }
  given!(:student3)  { create(:student) }
  given!(:student4)  { create(:student) }
  given!(:student5)  { create(:student) }
  given!(:student6)  { create(:student) }

  given!(:course1)  { create(:course,
                             semester_id: semester1.id,
                             teacher_id: teacher.id) }

  given!(:course2)  { create(:course,
                             semester_id: semester1.id,
                             teacher_id: teacher.id) }

  given!(:course3)  { create(:course,
                             semester_id: semester2.id,
                             teacher_id: teacher.id) }

  given!(:student_course1) { create(:student_course,
                                     student_id: student1.id,
                                     course_id: course1.id,
                                     grade: 1.0) }

  given!(:student_course2) { create(:student_course,
                                     student_id: student2.id,
                                     course_id: course1.id,
                                     grade: 2.0) }

  given!(:student_course3) { create(:student_course,
                                     student_id: student3.id,
                                     course_id: course2.id,
                                     grade: 3.0) }

  given!(:student_course4) { create(:student_course,
                                     student_id: student4.id,
                                     course_id: course2.id,
                                     grade: 4.0) }

  given!(:student_course5) { create(:student_course,
                                     student_id: student5.id,
                                     course_id: course3.id,
                                     grade: 0.0) }

  given!(:student_course6) { create(:student_course,
                                     student_id: student6.id,
                                     course_id: course3.id,
                                     grade: 2.0) }


  scenario "admin can see average course grade", js: true do
    log_in_as(admin)

    within(".course-list") do
      select(course1.name, from: "course-select")
      expect(page).to have_content(course1.name)
      expect(page).to have_content(1.5)

      select(course2.name, from: "course-select")
      expect(page).to have_content(course2.name)
      expect(page).to have_content(3.5)

      select(course3.name, from: "course-select")
      expect(page).to have_content(course3.name)
      expect(page).to have_content(1.0)
    end
  end


  scenario "admin can all semesters, the courses for that semester, and the number of students in those courses", js: true do
    log_in_as(admin)

    within(".semester-list") do
      select("#{semester1.begin_date} to #{semester1.end_date}", from: "semester-select")
      expect(page).to have_content("#{semester1.begin_date} to #{semester1.end_date}")
      expect(page).to have_content(course1.name)
      expect(page).to have_content(course1.students.count)
      expect(page).to have_content(course2.name)
      expect(page).to have_content(course2.students.count)

      select("#{semester2.begin_date} to #{semester2.end_date}", from: "semester-select")
      expect(page).to have_content("#{semester2.begin_date} to #{semester2.end_date}")
      expect(page).to have_content(course3.name)
      expect(page).to have_content(course3.students.count)
    end
  end
end