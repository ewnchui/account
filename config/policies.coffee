module.exports = 
  policies:
    UserController:
      '*': false
      find: ['isAuth']
      findOne: ['isAuth']
      create: ['isAuth']
      update: ['isAuth']
      add: ['isAuth'] 

    VoteController:
      '*': false
      find: ['isAuth']
      findOne: ['isAuth']
      create: ['isAuth']
      update: ['isAuth']
      add: ['isAuth']

    VoteTypeController:
      '*': false
      find: ['isAuth']
      findOne: ['isAuth']
      create: ['isAuth']
      update: ['isAuth']
      add: ['isAuth']

    BreakdownController:
      '*': false
      find: ['isAuth']
      findOne: ['isAuth']
      create: ['isAuth']
      update: ['isAuth']
      add: ['isAuth']
