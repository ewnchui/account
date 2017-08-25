module.exports = 
  policies:
    UserController:
      '*': false
      find: ['isAuth']
      findOne: ['isAuth']
      create: ['isAuth', 'isAdmin']
      update: ['isAuth', 'isAdmin']
      add: ['isAuth']
      remove: ['isAuth']

    VoteController:
      '*': false
      find: ['isAuth']
      findOne: ['isAuth']
      create: ['isAuth','isAdmin']
      update: ['isAuth','me', 'canUpdate']
      destroy: ['isAuth', 'me', 'canUpdate']
      add: ['isAuth', 'me', 'canUpdate']
      remove: ['isAuth', 'me', 'canUpdate']

    VoteTypeController:
      '*': false
      find: ['isAuth']
      findOne: ['isAuth']
      create: ['isAuth', 'isAdmin']
      update: ['isAuth', 'isAdmin']
      add: ['isAuth']
      remove: ['isAuth']

    BreakdownController:
      '*': false
      find: ['isAuth']
      findOne: ['isAuth']
      create: ['isAuth', 'setCreatedBy']
      update: ['isAuth']
      add: ['isAuth']
      remove: ['isAuth']
      sum: ['isAuth']
