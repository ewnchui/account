module.exports =
  tableName: 'breakdowns'

  schema: true

  attributes:
    group:
      type: 'string'
      required: true

    type:
      type: 'string'
      enum: ['maintenance','procurement','server farm','EGIS','virement']

    desc:
      type: 'string'

    qty:
      type: 'integer'

    estAmt:
      type: 'integer'

    vendor: 
      type: 'string'

    epsRef:
      type: 'string'

    PO:
      type: 'string'

    InvoiceDate:
      type: 'datetime'

    status:
      type: 'string'
      enum: ['outstanding','processing','pending settle','settled']

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
