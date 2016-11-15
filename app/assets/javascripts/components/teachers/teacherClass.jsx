var TeacherClass = React.createClass({
  render: function() {
    const { name, id } = this.props;
    return (
      <div className="dropdown classes">
        <button className="btn btn-default dropdown-toggle" type="button" id="dropdownMenu1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
          Class Name: <strong>{name} </strong>
          <span className="caret"></span>
        </button>
        <ul className="dropdown-menu" aria-labelledby="dropdownMenu1">
          <li><a href="#">Action</a></li>
          <li><a href="#">Action</a></li>
        </ul>
      </div>
    );
  }
});
