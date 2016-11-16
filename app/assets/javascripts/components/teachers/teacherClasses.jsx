var TeacherClasses = React.createClass({
  getInitialState: function () {
    return {
      classes: [],
      semester: '',
      semesterList: [],
      selectSemester: ''
    };
  },

  componentDidMount: function() {
    $.ajax({
      url: this.props.url,
      dataType: 'json',
      success: function (classes) {
        const semesterList = this.findPossibleSemesters(classes);
        this.setState({
          classes: classes,
          semester: classes[0].semester.beginDate,
          semesterList: semesterList
        });
      }.bind(this),
      error: function (xhr, status, err) {
        console.error(this.props.url, status, err.toString());
      }.bind(this)
    });
  },

  findPossibleSemesters: function(classes) {
    const possibleSemesters = classes.reduce(function(acc, teacherClass) {
      const semester = teacherClass.semester.id
      acc[teacherClass.semester.beginDate] = teacherClass.semester.endDate
      return acc
    }, {})
    return possibleSemesters
  },

  renderClasses: function(teacherClass) {
    return <TeacherClass key={teacherClass.id}
                         name={teacherClass.name}
                         description={teacherClass.description}
                         id={teacherClass.id}
                         students={teacherClass.studentCourses}
           />
  },

  semesterSelect: function(teacherClass) {
    const semesterId = this.state.semester;
    return teacherClass.semester.beginDate === semesterId
  },

  renderSemesters: function(semester) {
    return (
      <option key={semester} value={semester}>{semester}</option>
    )
  },

  handleChange(e) {
    this.setState({semester: e.target.value});
  },

  render: function() {
    return (
      <div>
        <h5>Please select a semester</h5>
        <select value={this.state.semester} onChange={this.handleChange}>
          {Object.keys(this.state.semesterList).map(this.renderSemesters)}
        </select>
        <div className="semester-selector">
          {this.state.classes.filter(this.semesterSelect).map(this.renderClasses)}
        </div>
      </div>
    );
  }
});
