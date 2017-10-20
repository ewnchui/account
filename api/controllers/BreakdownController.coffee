_ = require 'lodash'
actionUtil = require 'sails/lib/hooks/blueprints/actionUtil'

module.exports =
  status: (req, res) ->
    Model = actionUtil.parseModel(req)
    data = actionUtil.parseValues(req)
    cond =
      "createdDate": {">=": sails.services.finance.getStartDate(), "<=": sails.services.finance.getEndDate()}

    sails.log.debug "summarystatus groupby type status!!!!"

    Model.find()
      .sum('Amount')
      .groupBy('type', 'status')
      .where(cond)
      .then (results) ->
        sails.models.vote
          .find()
          .then (votes) ->
            _.each results, (r) ->
              r.vote = _.find(votes, 'id': "#{r.vote}")
            res.ok results
      .catch res.serverError
      
  summary: (req, res) ->
    Model = actionUtil.parseModel(req)
    data = actionUtil.parseValues(req)
    cond =
      "createdDate": {">=": sails.services.finance.getStartDate(),"<=": sails.services.finance.getEndDate()}
    sails.log.debug "status groupby type, vote!!!!"
    Model.find()
      .sum('Amount')
      .groupBy('type','vote')
      .where( cond )
      .then (results) ->
        sails.models.vote
          .find()
          .then (votes) ->
            _.each results, (r) ->
              r.vote = _.find(votes, 'id': "#{r.vote}") 
            res.ok results
      .catch res.serverError

   getStatus: (req, res) ->
     return res.ok sails.models.breakdown.attributes.status.enum
   getType: (req, res) ->
     return res.ok sails.models.breakdown.attributes.type.enum
   
