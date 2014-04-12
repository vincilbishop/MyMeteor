Meteor.publish ('car', function (make) {

  console.log ('Make: ' + make);
  return Car.find ({"make":make});
});

