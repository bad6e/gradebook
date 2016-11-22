require 'rails_helper'

RSpec.describe Api::V1::AdminsController, type: :controller do
  describe 'GET #show /api/v1/admins/:id/courses/:id' do
    context 'it takes an admin id and a course id and returns all grades for that course' do
      let!(:admin)    { create(:admin) }
      let!(:teacher)  { create(:teacher) }
      let!(:semester) { create(:semester) }
      let!(:student1) { create(:student) }
      let!(:student2) { create(:student) }
      let!(:student3) { create(:student) }
      let!(:student4) { create(:student) }

      let!(:course) { create(:course,
                             semester_id: semester.id,
                             teacher_id: teacher.id)
      }

      let!(:student_course1) { create(:student_course,
                                      student_id: student1.id,
                                      course_id: course.id,
                                      grade: 1.0)
      }

      let!(:student_course2) { create(:student_course,
                                      student_id: student2.id,
                                      course_id: course.id,
                                      grade: 2.0)
      }

      let!(:student_course3) { create(:student_course,
                                      student_id: student3.id,
                                      course_id: course.id,
                                      grade: 3.0)
      }

      let!(:student_course4) { create(:student_course,
                                      student_id: student4.id,
                                      course_id: course.id,
                                      grade: 4.0)
      }

      before do
        login(admin)
        get :all_course_grades, admin_id: current_user.id, id: course.id, type: 'Admin', format: :json
      end

      it { should respond_with 200 }

      it 'returns all the grades for a given course' do
        expect(response_data.length).to eq(4)
        expect(response_data).to eq([1.0, 2.0, 3.0, 4.0])
      end
    end

    context 'when there is no current_user' do
      before do
        get :all_course_grades, admin_id: 2, id: 1, type: 'Admin', format: :json
      end

      it { should respond_with 401 }

      it 'renders a json error' do
        expect(response_data[:error]).to eq('Must login for information.')
      end
    end

    context 'when current_user type is NOT admin' do
      let!(:student) { create(:student) }

      before do
        login(student)
        get :all_course_grades, admin_id: student.id, id: 1, type: 'Admin', format: :json
      end

      it { should respond_with 401 }

      it 'renders a json error' do
        expect(response_data[:error]).to eq('Admins Only.')
      end
    end

    context 'when current_user does not match user in params' do
      let!(:admin1) { create(:admin) }
      let!(:admin2) { create(:admin) }

      before do
        login(admin1)
        get :all_course_grades, admin_id: admin2.id, id: 1, type: 'Admin', format: :json
      end

      it { should respond_with 401 }

      it 'renders a json error' do
        expect(response_data[:error]).to eq('Admins can only see their own information.')
      end
    end
  end

  describe 'GET #show /api/v1/admins/:id/semesters/:id' do
    context 'it takes an admin id and a semester id and returns all the courses for that semester with the associated students' do
      let!(:admin)    { create(:admin) }
      let!(:teacher)  { create(:teacher) }
      let!(:semester) { create(:semester) }
      let!(:student1) { create(:student) }
      let!(:student2) { create(:student) }
      let!(:student3) { create(:student) }
      let!(:student4) { create(:student) }

      let!(:course1) { create(:course,
                              semester_id: semester.id,
                              teacher_id: teacher.id)
      }

      let!(:course2) { create(:course,
                              semester_id: semester.id,
                              teacher_id: teacher.id)
      }

      let!(:student_course1) { create(:student_course,
                                      student_id: student1.id,
                                      course_id: course1.id,
                                      grade: 1.0)
      }

      let!(:student_course2) { create(:student_course,
                                      student_id: student2.id,
                                      course_id: course1.id,
                                      grade: 2.0)
      }

      let!(:student_course3) { create(:student_course,
                                      student_id: student3.id,
                                      course_id: course2.id,
                                      grade: 3.0)
      }

      let!(:student_course4) { create(:student_course,
                                      student_id: student4.id,
                                      course_id: course2.id,
                                      grade: 4.0)
      }

      before do
        login(admin)
        get :enrollment_counts, admin_id: current_user.id, id: semester.id, type: 'Admin', format: :json
      end

      it { should respond_with 200 }

      it 'returns all the courses that belong to that semester' do
        expect(response_data.length).to eq(2)
      end

      it 'returns the course name and description' do
        expect(response_data[0].dig(:name)).to eq(course1.name)
        expect(response_data[1].dig(:name)).to eq(course2.name)
        expect(response_data[0].dig(:description)).to eq(course1.description)
        expect(response_data[1].dig(:description)).to eq(course2.description)
      end

      it 'returns the all the students full names' do
        expect(response_data[0].dig(:students)[0].dig(:fullName)).to eq(student1.full_name)
        expect(response_data[0].dig(:students)[1].dig(:fullName)).to eq(student2.full_name)
      end
    end

    context 'when there is no current_user' do
      before do
        get :enrollment_counts, admin_id: 2, id: 1, type: 'Admin', format: :json
      end

      it { should respond_with 401 }

      it 'renders a json error' do
        expect(response_data[:error]).to eq('Must login for information.')
      end
    end

    context 'when current_user type is NOT admin' do
      let!(:student) { create(:student) }

      before do
        login(student)
        get :enrollment_counts, admin_id: student.id, id: 1, type: 'Admin', format: :json
      end

      it { should respond_with 401 }

      it 'renders a json error' do
        expect(response_data[:error]).to eq('Admins Only.')
      end
    end

    context 'when current_user does not match user in params' do
      let!(:admin1) { create(:admin) }
      let!(:admin2) { create(:admin) }

      before do
        login(admin1)
        get :enrollment_counts, admin_id: admin2.id, id: 1, type: 'Admin', format: :json
      end

      it { should respond_with 401 }

      it 'renders a json error' do
        expect(response_data[:error]).to eq('Admins can only see their own information.')
      end
    end
  end
end
