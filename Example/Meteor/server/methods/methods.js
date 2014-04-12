Meteor.methods(
  {
    testMethod : function(parameter)
    {
      console.log("parameter: " + parameter);

      return parameter;
    }
  }
);