require 'rails_helper'

RSpec.describe Api::V1::TeachersController, type: :controller do
  describe "GET #show /api/v1/teachers/:id" do

    context "it takes a teachers id and returns the all the all the teachers courses with students, grades, semesters" do
      let!(:teacher)   { create(:teacher) }
      let!(:semester)  { create(:semester) }
      let!(:student1)  { create(:student) }
      let!(:student2)  { create(:student) }
      let!(:student3)  { create(:student) }

      let!(:course1)  { create(:course,
                                semester_id: semester.id,
                                teacher_id: teacher.id) }

      let!(:course2)  { create(:course,
                                semester_id: semester.id,
                                teacher_id: teacher.id) }

      let! (:student_course1) { create(:student_course,
                                         student_id: student1.id,
                                         course_id: course1.id,
                                         grade: 2.0) }

      let! (:student_course2) { create(:student_course,
                                         student_id: student2.id,
                                         course_id: course1.id,
                                         grade: 4.0) }

      let! (:student_course3) { create(:student_course,
                                         student_id: student3.id,
                                         course_id: course2.id,
                                         grade: 1.0) }
      before do
        login(teacher)
        get :show, id: current_user.id, type: 'Teacher',format: :json
      end

      it "returns all the courses that the teacher teaches" do
        expect(response_data.length).to eq(2)
      end

      it "returns the course name and description" do
        expect(response_data[0].dig(:name)).to eq(course1.name)
        expect(response_data[0].dig(:description)).to eq(course1.description)
      end

      it "returns the course's semester" do
        expect(response_data[0].dig(:semester, :id)).to eq(semester.id)
      end

      it "returns the all the students' full names and grades" do
        expect(response_data[0].dig(:studentCourses)[0].dig(:students, :grade)).to eq(student_course1.grade)
        expect(response_data[0].dig(:studentCourses)[1].dig(:students, :grade)).to eq(student_course2.grade)

        expect(response_data[0].dig(:studentCourses)[0].dig(:students, :fullName)).to eq(student1.full_name)
        expect(response_data[0].dig(:studentCourses)[1].dig(:students, :fullName)).to eq(student2.full_name)
      end
    end

    context "when there is no current_user" do
      before do
        get :show, id: 2, type: 'Teacher',format: :json
      end

      it "renders a json error" do
        expect(response_data[:error]).to eq("Must login for information.")
      end
    end

    context "when current_user does not match user in params" do
      let!(:teacher)  { create(:teacher) }

      before do
        login(teacher)
        get :show, id: 20000, type: 'Teacher',format: :json
      end

      it "renders a json error" do
        expect(response_data[:error]).to eq("Teachers can only see their own classes.")
      end
    end
  end
end
