var Courses = React.createClass({
  getInitialState: function () {
    return {
      courses: [],
      selectedSemester: '',
      semesterList: []
    };
  },

  componentDidMount: function() {
    $.ajax({
      url: this.props.url,
      dataType: 'json',
      success: function (courses) {
        const semesterList = this.findPossibleSemesters(courses);
        this.setState({
          courses: courses,
          selectedSemester: courses[0].semester.semesterName,
          semesterList: semesterList
        });
      }.bind(this),
      error: function (xhr, status, err) {
        console.error(this.props.url, status, err.toString());
      }.bind(this)
    });
  },

  findPossibleSemesters: function(courses) {
    const possibleSemesters = courses.reduce(function(acc, course) {
      acc[course.semester.semesterName] = course.semester.endDate
      return acc
    }, {})
    return possibleSemesters
  },

  renderCourses: function(course) {
    return <CourseDescription key={course.id}
                              name={course.name}
                              description={course.description}
                              id={course.id}
                              studentsOfCourse={course.studentCourses}
           />
  },

  semesterSelect: function(teacherClass) {
    const semesterId = this.state.selectedSemester;
    return teacherClass.semester.semesterName === semesterId
  },

  renderSemesters: function(semester) {
    return (
      <option key={semester} value={semester}>{semester}</option>
    )
  },

  avgSemesterGrade: function() {
    if (this.props.type === "Student") {
      return this.calculateSemesterGrade(this.state.courses.filter(this.semesterSelect));
    }
  },

  calculateSemesterGrade: function(allCourses) {
    const totalGrade = _.reduce(allCourses, function(sum, n) {
      return sum + n.studentCourses[0].students.grade/allCourses.length;
    }, 0);
    return (
      `Semester Grade: ${(totalGrade).toFixed(2)}`
    )
  },

  handleChange(e) {
    this.setState({selectedSemester: e.target.value});
  },

  render: function() {
    return (
      <div>
        <h5>Please select a semester</h5>
        <select value={this.state.selectedSemester} onChange={this.handleChange}>
          {Object.keys(this.state.semesterList).map(this.renderSemesters)}
        </select>
        <div className="semester-selector">
          {this.avgSemesterGrade()}
          {this.state.courses.filter(this.semesterSelect).map(this.renderCourses)}
        </div>
      </div>
    );
  }
});
