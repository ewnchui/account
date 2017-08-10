module.exports =
  tableName: 'users'

  schema: true

  attributes:
    username:
      type: 'string'
      required: true

    email:
      type: 'string'
      required: true
      unique: true

    postTitle:
      type: 'string'

    manage:
      collection: 'vote'
      via: 'ownedBy'

    createTrans:
      collection: 'breakdown'
      via: 'createdBy'

    settleTrans:
      collection: 'breakdown'
      via: 'settledBy'


