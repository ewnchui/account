module.exports =
  tableName: 'breakdowns'

  schema: true

  attributes:
    project:
      type: 'string'
      required: true

    desc:
      type: 'string'

    estAmt:
      type: 'integer' 

    vendor: 
      type: 'string'

    epsRef:
      type: 'string'

    PO:
      type: 'string'

    InvDate:
      type: 'datetime'

    status:
      type: 'string'

    maintStartDate:
      type: 'datetime'

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

    vote:
      model: 'vote'
