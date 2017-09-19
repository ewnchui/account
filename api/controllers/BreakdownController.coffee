#BreakdownController
_ = require 'lodash'
actionUtil = require 'sails/lib/hooks/blueprints/actionUtil'
Promise = require 'bluebird'

module.exports = 
  status: (req, res) ->
    Model = actionUtil.parseModel(req)
    data = actionUtil.parseValues(req)
    cond =
      "createdDate": {">=": sails.services.finance.getStartDate(),"<=": sails.services.finance.getEndDate()}
    sails.log.info "cond: #{JSON.stringify cond}"

    Model.find()
      .sum('Amount')
      .groupBy('type','status','vote')
      .where( cond )
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
      status: 'settled'
      "createdDate": {">=": sails.services.finance.getStartDate(),"<=": sails.services.finance.getEndDate()}
    _.extend data, cond
    sails.log.info "data: #{JSON.stringify data}"

    Model.find()
      .sum('Amount')
      .where( data )
      .then (results) ->
        res.ok results[0]
      .catch res.serverError

  getStatus: (req, res) ->
    return res.ok sails.models.breakdown.attributes.status.enum

  getType: (req, res) ->
    return res.ok sails.models.breakdown.attributes.type.enum


