_ = require 'lodash'
actionUtil = require 'sails/lib/hooks/blueprints/actionUtil'


module.exports =
  sum: (req, res) ->
    Model = actionUtil.parseModel req
    where = actionUtil.parseCriteria req

    Model
      .find where
      .sum('Amt')
      .then (result) ->
         sails.log.debug "result: #{JSON.stringify(result)}"
         res.ok result
      .catch res.serverError

   getStatus: (req, res) ->
     return res.ok sails.models.breakdown.attributes.status.enum

   getType: (req, res) ->
     return res.ok sails.models.breakdown.attributes.type.enum

   
