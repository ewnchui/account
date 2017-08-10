module.exports = (req, res, next) ->
	req.options.values = req.options.values || {}
	req.options.values.ownedBy = req.user
	next()
