env = require './env.coffee'
Promise = require 'promise'

angular
	.module 'starter.controller', [
		'ionic' 
		'ngCordova'
		'http-auth-interceptor'
		'starter.model'
		'platform'
	]
	
	.controller 'MenuCtrl', ($scope) ->
		_.extend $scope,
			env: env
			navigator: navigator
			
						
	.controller 'AccountListCtrl', ($scope, collection, $location, $ionicPopup) ->
		_.extend $scope,
			collection: collection
			loadMore: ->
				collection.$fetch()
					.then ->
						$scope.$broadcast('scroll.infiniteScrollComplete')
					.catch alert
