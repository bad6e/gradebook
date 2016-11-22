require 'rails_helper'

RSpec.describe Api::V1::StudentsController, type: :controller do
  describe 'GET #show /api/v1/students/:id' do
    context 'it takes a student id and returns the all the students courses with grade and semester' do
      let!(:student)  { create(:student) }
      let!(:teacher)  { create(:teacher) }
      let!(:semester) { create(:semester) }

      let!(:course1) { create(:course,
                              semester_id: semester.id,
                              teacher_id: teacher.id)
      }

      let!(:course2) { create(:course,
                              semester_id: semester.id,
                              teacher_id: teacher.id)
      }

      let!(:student_course1) { create(:student_course,
                                      student_id: student.id,
                                      course_id: course1.id,
                                      grade: 4.0)
      }

      let!(:student_course2) { create(:student_course,
                                      student_id: student.id,
                                      course_id: course2.id,
                                      grade: 3.0)
      }

      before do
        login(student)
        get :show, id: current_user.id, type: 'Student', format: :json
      end

      it 'returns all the courses the student is in' do
        expect(response_data.length).to eq(2)
      end

      it 'returns the course name and description' do
        expect(response_data[0].dig(:name)).to eq(course1.name)
        expect(response_data[0].dig(:description)).to eq(course1.description)
      end

      it "returns the course's semester" do
        expect(response_data[0].dig(:semester, :id)).to eq(semester.id)
      end

      it 'returns the students id, full name, grade' do
        expect(response_data[0].dig(:studentCourses)[0].dig(:students, :id)).to eq(student.id)
        expect(response_data[0].dig(:studentCourses)[0].dig(:students, :grade)).to eq(student_course1.grade)
        expect(response_data[0].dig(:studentCourses)[0].dig(:students, :fullName)).to eq(student.full_name)
      end
    end

    context 'when there is no current_user' do
      before do
        get :show, id: 2, type: 'Student', format: :json
      end

      it 'renders a json error' do
        expect(response_data[:error]).to eq('Must login for information.')
      end
    end

    context 'when current_user does not match user in params' do
      let!(:student) { create(:student) }

      before do
        login(student)
        get :show, id: 200_000, type: 'Student', format: :json
      end

      it 'renders a json error' do
        expect(response_data[:error]).to eq('Students can only see their own schedule and grades.')
      end
    end
  end
end
