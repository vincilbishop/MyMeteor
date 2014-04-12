Meteor.startup (
  function () {

    OgnoAdmin.config ({
      prefix: '/admin',
      auto: true,
      isAllowed: function () {
        return true;
        var user = Meteor.user ();

        if (user) {
          return 'admin' === user.username;
        }
      }
    });

  }
);