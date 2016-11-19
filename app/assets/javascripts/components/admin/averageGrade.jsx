var AverageGrade = React.createClass({
  getInitialState: function () {
    return {
      averageGrades: []
    };
  },

  componentDidMount: function() {
    if (this.props.id) {
      $.ajax({
        url: `/api/v1/admins/${this.props.user}/grades/${this.props.id}`,
        dataType: 'json',
        success: function (grades) {
          this.setState({
            averageGrades: grades,
          });
        }.bind(this),
        error: function (xhr, status, err) {
          console.error(this.props.url, status, err.toString());
        }.bind(this)
      });
    }
  },

  calculateAvgGrade: function(grades) {
    const avgGrade = _.reduce(grades, function(sum, n) {
      return sum + n/grades.length;
    }, 0);
    return avgGrade
  },

  render: function() {
    const averageGrade = this.calculateAvgGrade(this.state.averageGrades);

    return (
      <div className="container">
        <div className="col-mid-12">
          <h5>Avg Grade: {(averageGrade).toFixed(2)}</h5>
        </div>
      </div>
    );
  }
});