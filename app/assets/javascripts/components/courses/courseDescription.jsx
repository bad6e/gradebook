var CourseDescription = React.createClass({

  renderStudent: function(student) {
    const std = student.students
    return <Student key={std.id}
                    student={std.fullName}
                    grade={std.grade}
    />
  },

  render: function() {
    const { id, name, description, studentsOfCourse } = this.props;

    return (
      <div className="dropdown classes">
        <a href="#" data-toggle="dropdown" className="dropdown-toggle">Class Name: <strong>{name} </strong>
          <span className="caret"></span>
        </a>
        <ul className="dropdown-menu" aria-labelledby="dropdownMenu1">
          <li>Description: {description}</li><br/>
          <h5>Students</h5>
          {(this.props.studentsOfCourse).map(this.renderStudent)}
        </ul>
      </div>
    );
  }
});
