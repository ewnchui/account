module.exports =
  tableName: 'breakdowns'

  schema: true

  attributes:
    desc:
      type: 'string'

    estAmt:
      type: double

    vendor: 
      type: 'string'

    createdDate:
	  type: 'datetime'
	  defaultsTo: ->
		new Date  

    createdBy:
      model: 'user'  
      required: true

    completedDate:
      type: 'datetime'

    settledBy:
      model: 'user'  
      required: true

    vote:
      model: 'vote'
