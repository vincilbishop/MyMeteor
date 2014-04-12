Car = new Meteor.Collection2('car', { 'schema' : {

  make: {
    type: String,
    label: 'Make'
  },
  model: {
    type: String,
    label: 'Model'
  }

} });

// Collection2 already does schema checking
// Add custom permission rules if needed
Car.allow({
    insert : function () {
        return true;
    },
    update : function () {
        return true;
    },
    remove : function () {
        return true;
    }
});

