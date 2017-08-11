module.exports =
  tableName: 'votes'

  schema: true

  attributes:
    code: 
      type: 'string'
      required: true
      unique: true

    refNo:
      type: 'string'

    desc:
      type: 'string'

    type:
      model: 'voteType'
    
    details:
      collection: 'breakdown'
      via: 'vote'

    ownedBy:
      model: 'user'
