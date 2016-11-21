require "rails_helper"

feature "Teacher can see statistics" do
  given!(:teacher1)   { create(:teacher) }
  given!(:teacher2)   { create(:teacher) }
  given!(:semester1) { create(:semester) }
  given!(:semester2) { create(:semester) }
  given!(:semester2) { create(:semester) }
  given!(:student1)  { create(:student) }
  given!(:student2)  { create(:student) }
  given!(:student3)  { create(:student) }
  given!(:student4)  { create(:student) }
  given!(:student5)  { create(:student) }
  given!(:student6)  { create(:student) }

  given!(:course1)  { create(:course,
                             semester_id: semester1.id,
                             teacher_id: teacher1.id) }

  given!(:course2)  { create(:course,
                             semester_id: semester2.id,
                             teacher_id: teacher1.id) }

  given!(:course3)  { create(:course,
                             semester_id: semester1.id,
                             teacher_id: teacher2.id) }

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


  scenario "teacher can see semester list - select a semester - and see all their courses for that semester", js: true do
    log_in_as(teacher1)

    within(".teacher-semester-list") do
      select("#{semester1.begin_date} to #{semester1.end_date}", from: "semesters-select")
      expect(page).to have_content(course1.name)

      select("#{semester2.begin_date} to #{semester2.end_date}", from: "semesters-select")
      expect(page).to have_content(course2.name)
    end
  end


  scenario "From a selected course - a teacher can see all the students in that course and their respective grades", js: true do
    log_in_as(teacher1)

    within(".teacher-semester-list") do
      select("#{semester1.begin_date} to #{semester1.end_date}", from: "semesters-select")

      click_on(course1.name)

      expect(page).to have_content(student1.full_name)
      expect(page).to have_content(student2.full_name)

      student_1_grade = StudentCourse.where(student_id: student1.id, course_id: course1.id).first
      expect(page).to have_content(student_1_grade.grade)

      student_2_grade = StudentCourse.where(student_id: student2.id, course_id: course1.id).first
      expect(page).to have_content(student_2_grade.grade)

      select("#{semester2.begin_date} to #{semester2.end_date}", from: "semesters-select")

      click_on(course2.name)

      expect(page).to have_content(student3.full_name)
      expect(page).to have_content(student4.full_name)

      student_3_grade = StudentCourse.where(student_id: student3.id, course_id: course2.id).first
      expect(page).to have_content(student_3_grade.grade)

      student_4_grade = StudentCourse.where(student_id: student4.id, course_id: course2.id).first
      expect(page).to have_content(student_4_grade.grade)
    end
  end
end