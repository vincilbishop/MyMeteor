Truck = new Meteor.Collection2('truck', { 'schema' : {} });

// Collection2 already does schema checking
// Add custom permission rules if needed
Truck.allow({
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

