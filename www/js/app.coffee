env = require './env.coffee'
require 'log_toast'

angular
	.module 'starter', [
		'ionic', 
		'starter.controller', 
		'starter.model', 
		'util.auth', 
		'ionic-datepicker', 
		'ngFancySelect', 
		'pascalprecht.translate', 
		'locale'
		'logToast'
	]

	.run (authService) ->
		authService.login env.oauth2().opts
		
	.run ($rootScope, platform, $ionicPlatform, $location, $http) ->
		$ionicPlatform.ready ->
			if (window.cordova && window.cordova.plugins.Keyboard)
				cordova.plugins.Keyboard.hideKeyboardAccessoryBar(true)
			if (window.StatusBar)
				StatusBar.styleDefault()
						
	.config ($stateProvider, $urlRouterProvider) ->
		$stateProvider.state 'app',
			url: ""
			abstract: true
			templateUrl: "templates/menu.html"
	
		# Account
		$stateProvider.state 'app.accountList',
			url: "/account/list"
			cache: false
			views:
				'menuContent':
					templateUrl: "templates/account/list.html"
					controller: 'AccountListCtrl'
			resolve:
				cliModel: 'model'	
				collection: (cliModel) ->
					ret = new cliModel.DbList()
					ret.$fetch()
					
		$urlRouterProvider.otherwise('/account/list')
