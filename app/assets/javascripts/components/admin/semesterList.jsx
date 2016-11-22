var SemesterList = React.createClass({
  getInitialState: function () {
    return {
    semesters: [],
    selectedSemester: ''
    };
  },

  componentDidMount: function() {
    $.ajax({
      url: this.props.url,
      dataType: 'json',
      success: function (semesters) {
        this.setState({
          semesters: semesters,
          selectedSemester: semesters[0].id
        });
      }.bind(this),
      error: function (xhr, status, err) {
        console.error(this.props.url, status, err.toString());
      }.bind(this)
    });
  },

  renderSemesters: function(semester) {
    return (
      <option key={semester.id} value={semester.id}>{semester.semesterName}</option>
    )
  },

  handleChange(e) {
    this.setState({selectedSemester: e.target.value});
  },

  render: function() {
    return (
      <div>
        <h5>Please select a semester for enrollment accounts:</h5>
        <select name="semester-select" value={this.state.renderSemesters} onChange={this.handleChange}>
          {this.state.semesters.map(this.renderSemesters)}
        </select>
        <Enrollments key={this.state.selectedSemester}
                     id={this.state.selectedSemester}
                     user={this.props.user}
        />
      </div>
    );
  }
});
