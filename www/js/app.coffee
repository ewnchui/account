env = require './env.coffee'
require 'log_toast'

angular
  .module 'starter', [
    'ionic', 
    'starter.controller', 
    'starter.model', 
    'util.auth', 
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

    $stateProvider.state 'app.voteList',
      url: "/vote"
      cache: false
      views:
        'menuContent':
           templateUrl: "templates/vote/list.html"
           controller: 'VoteListCtrl'
      resolve:
        cliModel: 'model'
        collection: (cliModel) ->
          ret = new cliModel.VoteList()
          ret.$fetch()

    $stateProvider.state 'app.voteCreate',
      url: "/vote/create"
      cache: false
      views:
        'menuContent':
           templateUrl: "templates/vote/create.html"
           controller: 'VoteCtrl'
      resolve:
        cliModel: 'model'
        votetypeList : (cliModel) ->
          ret = new cliModel.VoteTypeList().$fetch();
        model: (cliModel) ->
          ret = new cliModel.Vote()


  
    $urlRouterProvider.otherwise('/vote')
