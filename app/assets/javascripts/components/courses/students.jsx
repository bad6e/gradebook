var Students = React.createClass({
  renderStudents: function(student) {
    const std = student.students;
    return (
      <li>{std.fullName} | Grade: {std.grade.toFixed(2)}</li>
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
