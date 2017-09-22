assert = require 'assert'
actionUtil = require 'sails/lib/hooks/blueprints/actionUtil'

[
  'ADMIN'
].map (name) ->
  assert name of process.env, "process.env.#{name} not yet defined"

module.exports = (req, res, next) ->
  pk = actionUtil.requirePk(req)
  admin = process.env.ADMIN.split ','
  Model = actionUtil.parseModel(req)

  # check if authenticated user is admin
  if req.user.email in admin
    return next()

  cond = 
    id: pk
    createdBy: req.user.username
  Model.findOne()
    .where(cond)
    .exec(err, data) ->
      if err
        return res.serverError err
      if data
        return next()
      
      res.forbidden()
