module.exports =
  tableName: 'users'

  schema: true

  attributes:
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


