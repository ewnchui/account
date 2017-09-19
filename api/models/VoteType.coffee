module.exports =
  tableName: 'voteTypes'

  schema: true

  attributes:
    code: 
      type: 'string'
      required: true      
      unique: true

    votes:
      collection: 'vote'
      via: 'type'
