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

    $stateProvider.state 'app.votetypeList',
      url: "/votetype/list"
      cache: false
      views:
        'menuContent':
          templateUrl: "templates/votetype/list.html"
          controller: 'VoteTypeListCtrl'
      resolve:
        cliModel: 'model'
        collection: (cliModel) ->
          ret = new cliModel.VoteTypeList().$fetch()

    $stateProvider.state 'app.votetypeCreate',
      url: "/votetype/create"
      cache: false
      views:
        'menuContent':
           templateUrl: "templates/votetype/create.html"
           controller: 'VoteTypeCtrl'
      resolve:
        cliModel: 'model'
        model: (cliModel) ->
          ret = new cliModel.VoteType()
        voteList: (cliModel) ->
          ret = new cliModel.VoteList().$fetch()

    $stateProvider.state 'app.votetypeDetails',
      url: "/votetype/read/:id"
      cache: false
      views:
        'menuContent':
           templateUrl: "templates/votetype/read.html"
           controller: 'VoteTypeCtrl'
      resolve:
        cliModel: 'model'
        id: ($stateParams) ->
          $stateParams.id
        voteList: (cliModel) ->
          ret = new cliModel.VoteList().$fetch()
        model: (cliModel, id) ->
          ret = new cliModel.VoteType({id:id}).$fetch()

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
          ret = new cliModel.VoteList().$fetch()

    $stateProvider.state 'app.voteCreate',
      url: "/vote/create"
      cache: false
      views:
        'menuContent':
           templateUrl: "templates/vote/create.html"
           controller: 'VoteCtrl'
      resolve:
        cliModel: 'model'
        model: (cliModel) ->
          ret = new cliModel.Vote()
        votetypeList : (cliModel) ->
          ret = new cliModel.VoteTypeList().$fetch()
        userList: (cliModel) ->
          ret = new cliModel.UserList().$fetch()
        
    $stateProvider.state 'app.voteUpdate',
      url: "/vote/update/:id"
      cache: false
      views:
        'menuContent':
           templateUrl: "templates/vote/update.html"
           controller: 'VoteCtrl'
      resolve:
        cliModel: 'model'
        id: ($stateParams) ->
          $stateParams.id
        userList: (cliModel) ->
          ret = new cliModel.UserList().$fetch()
        votetypeList : (cliModel) ->
          ret = new cliModel.VoteTypeList().$fetch()
        model: (cliModel, id) ->
          ret = new cliModel.Vote({id:id}).$fetch()

    $stateProvider.state 'app.breakdownList',
      url: "/breakdown/list?sort=vote"
      cache: false
      views:
        'menuContent':
          templateUrl: "templates/breakdown/list.html"
          controller: 'BreakdownListCtrl'
      resolve:
        sort: ($stateParams) ->
          return $stateParams.sort
        cliModel: 'model'
        collection: (cliModel, sort) ->
          ret = new cliModel.BreakdownList()
          ret.$fetch params: sort: sort

    $stateProvider.state 'app.breakdownCreate',
      url: "/breakdown/create"
      cache: false
      views:
        'menuContent':
          templateUrl: "templates/breakdown/create.html"
          controller: "BreakdownCtrl"
      resolve:
        cliModel: 'model'
        model: (cliModel) ->
          ret = new cliModel.Breakdown()
        typeList: (model) ->
          ret = model.selType()
        statusList: (model) ->
          ret = model.selStatus()
        voteList: (cliModel) ->
          ret = new cliModel.VoteList().$fetch()
        userList: (cliModel) ->
          ret = new cliModel.UserList().$fetch()

    $urlRouterProvider.otherwise('/vote')
