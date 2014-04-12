Meteor.publish('truck', function () {
    return Truck.find();
});

