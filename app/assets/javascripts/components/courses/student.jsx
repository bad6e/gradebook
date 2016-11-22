var Student = React.createClass({
  render: function() {
    return (
      <div>
        <li>{this.props.student} | Grade: {this.props.grade.toFixed(2)}</li>
      </div>
    );
  }
});