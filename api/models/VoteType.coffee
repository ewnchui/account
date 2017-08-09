module.exports =
  tableName: 'voteTypes'

  schema: true

  attributes:
    code: 
      type: 'string'
      required: true      
      unique: true

    vote:
      collection: 'vote'
      via: 'type'

