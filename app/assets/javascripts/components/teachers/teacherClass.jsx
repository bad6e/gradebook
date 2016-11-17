var TeacherClass = React.createClass({
  render: function() {
    const { id, name, description, students } = this.props;
    return (
      <div className="dropdown classes">
        <a href="#" data-toggle="dropdown" className="dropdown-toggle">Class Name: <strong>{name} </strong>
          <span className="caret"></span>
        </a>

        <ul className="dropdown-menu" aria-labelledby="dropdownMenu1">
          <li>Description: {description}</li><br/>
          <h5>Students</h5>
          <TeacherClassStudents
            key={id}
            students={students}
          />
        </ul>
      </div>
    );
  }
});
