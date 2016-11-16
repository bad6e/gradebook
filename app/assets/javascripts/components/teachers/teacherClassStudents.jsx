var TeacherClassStudents = React.createClass({
  renderStudents: function(student) {
    return (
      <li><a href="#">{student.studentName.fullName} | Grade: {student.grade}</a></li>
    )
  },

  render: function() {
    return (
      <div>
        {this.props.students.map(this.renderStudents)}
      </div>
    );
  }
});