var TeacherClasses = React.createClass({
  getInitialState: function () {
    return {
      classes: []
    };
  },

  componentDidMount: function() {
    $.ajax({
      url: this.props.url,
      dataType: 'json',
      success: function (classes) {
        this.setState({
          classes: classes
        });
      }.bind(this),
      error: function (xhr, status, err) {
        console.error(this.props.url, status, err.toString());
      }.bind(this)
    });
  },

  renderClasses: function(teacherClass) {
    return <TeacherClass key= {teacherClass.id}
                         name= {teacherClass.name}
                         id=  {teacherClass.id}
           />
  },

  render: function() {
    return (
      <div>
        {this.state.classes.map(this.renderClasses)}
      </div>
    );
  }
});