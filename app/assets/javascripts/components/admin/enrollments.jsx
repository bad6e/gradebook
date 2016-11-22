var Enrollments = React.createClass({
  getInitialState: function () {
    return {
      enrollments: []
    };
  },

  componentDidMount: function() {
    if (this.props.id) {
      $.ajax({
        url: `/api/v1/admins/${this.props.user}/semesters/${this.props.id}`,
        dataType: 'json',
        success: function (enrollments) {
          this.setState({
            enrollments: enrollments,
          });
        }.bind(this),
        error: function (xhr, status, err) {
          console.error(this.props.url, status, err.toString());
        }.bind(this)
      });
    }
  },

  renderCourses: function(course) {
    return (
      <li key={course.id}>{course.name}: {course.students.length} Student(s)</li>
    )
  },

  render: function() {
    return (
      <div className="container">
        <div className="col-mid-12">
          <h5>{this.state.enrollments.map(this.renderCourses)}</h5>
        </div>
      </div>
    );
  }
});
