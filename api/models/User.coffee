module.exports =
  tableName: 'users'

  schema: true

  attributes:
    username:
      type: 'string'
      required: true
      unique: true

    manage:
      collection: 'vote'
      via: 'ownedBy'

    createTrans:
      collection: 'breakdown'
      via: 'createdBy'

    settleTrans:
      collection: 'breakdown'
      via: 'settledBy'


