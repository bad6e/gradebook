var CourseList = React.createClass({
  getInitialState: function () {
    return {
      courses: [],
      selectedCourse: ''
    };
  },

  componentDidMount: function() {
    $.ajax({
      url: this.props.url,
      dataType: 'json',
      success: function (courses) {
        this.setState({
          courses: courses,
          selectedCourse: courses[0].id
        });
      }.bind(this),
      error: function (xhr, status, err) {
        console.error(this.props.url, status, err.toString());
      }.bind(this)
    });
  },

  renderCourses: function(course) {
    return (
      <option key={course.id} value={course.id}>{course.name}</option>
    )
  },

  handleChange(e) {
    this.setState({selectedCourse: e.target.value});
  },

  render: function() {
    return (
      <div>
        <h5>Please select a course for average course grade:</h5>
        <select name="course-select" value={this.state.selectedCourse} onChange={this.handleChange}>
          {this.state.courses.map(this.renderCourses)}
        </select>
        <AverageGrade key={this.state.selectedCourse}
                      id={this.state.selectedCourse}
                      user={this.props.user}
        />
      </div>
    );
  }
});
