module.exports =
  tableName: 'votes'

  schema: true

  attributes:
    code: 
      type: 'string'
      required: true
      unique: true

    projRefNo:
      type: 'string'

    desc:
      type: 'string'

    type:
      model: 'voteType'
    
    details:
      collection: 'breakdown'
      via: 'vote'

    ownedBy: 
      collection: 'user'
      via: 'manage'
