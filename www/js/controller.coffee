env = require './env.coffee'
Promise = require 'bluebird'

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

  .controller 'VoteTypeListCtrl', ($scope, collection, $location) ->
    _.extend $scope,
      collection: collection
      create: ->
        $location.url '/votetype/create'
      details: (id)->
        $location.url "/votetype/read/#{id}"
      delete: (obj) ->
        collection.remove obj
      loadMore: ->
        collection.$fetch()
          .then ->
            $scope.$broadcast('scroll.infiniteScrollComplete')
          .catch alert

  .controller 'VoteTypeCtrl', ($scope, model, $location, $log, $ionicModal, voteList) ->
    _.extend $scope,
      model: model
      voteList: voteList.models
      update: (id) ->
        $location.url "/vote/update/#{id}"
      select: (vote) ->
        $scope.model.vote = vote
        $scope.voteModal.hide()
      save: ->
        if not $scope.model.code
          $log.error 'Code is required'
        else
          $scope.model.$save()
             .then ->
                $location.url "/votetype"

  .controller 'VoteCtrl', ($scope, model, $location, $log, $ionicModal, votetypeList, userList) ->
    $ionicModal
      .fromTemplateUrl 'templates/votetype/type.html',
        scope: $scope
      .then (modal) ->
        $scope.typeModal = modal

    $ionicModal
       .fromTemplateUrl 'templates/user/user.html',
         scope: $scope
       .then (modal) ->
         $scope.userModal = modal

    _.extend $scope,
      model: model
      votetypeList: votetypeList.models
      userList: _.map userList.models, (user) -> _.pick user, 'email', 'id', 'postTitle'
      selectUser: (user) ->
        $scope.model.ownedBy = user
        $scope.userModal.hide()
      select: (type) ->
        $scope.model.type = type
        $scope.typeModal.hide()
      save: ->
        if not $scope.model.code
          $log.error "Code is required"
        else
          $scope.model.$save()
             .then ->
                $location.url "/vote"
    $scope.$on '$destory', ->
      $scope.typeModal.remove()
      
  .controller 'VoteListCtrl', ($scope, collection, $location) ->
    _.extend $scope,
      collection: collection
      create: ->
        $location.url "/vote/create"
      update: (id) ->
        $location.url "/vote/update/#{id}"
      delete: (obj) ->
        collection.remove obj
      loadMore: ->
        collection.$fetch()
          .then ->
            $scope.$broadcast('scroll.infiniteScrollComplete')
          .catch alert

  .controller 'BreakdownCtrl', ($scope, model, $location, $ionicModal, voteList, userList, statusList, typeList) ->
    $ionicModal
      .fromTemplateUrl 'templates/breakdown/attrType.html',
        scope: $scope
      .then (modal) ->
        $scope.attrModal = modal

    attrList = 
      Vote: voteList.models
      User: _.map userList.models, (user) -> _.pick user, 'email', 'id', 'postTitle'
      Status: statusList
      Type: typeList

    selectList = []

    _.extend $scope,
      model: model
      selectList: selectList
      selectAttr: (attr) ->
        $scope.attr = attr
        _.each attrList, (list, key) ->
          if key == attr
            $scope.selectList = list
      select: (item) ->
        if $scope.attr == "Vote"
          $scope.model.vote = item
        else if $scope.attr == "User"
          $scope.model.settledBy = item
        else if $scope.attr == "Status"
          $scope.model.status = item
        else
          $scope.model.type = item
        $scope.attrModal.hide()
      save: ->
        if not $scope.model.desc
          $log.error "Item Description is required"
        else
          $scope.model.$save()
             .then ->
                $location.url "/breakdown/list?sort=vote"
  
  .controller 'BreakdownListCtrl', ($scope, sort, collection, $location, $ionicPopup) ->
    _.extend $scope,
      collection: collection
      create: ->
        $location.url "/breakdown/create"
      loadMore: ->
        collection.$fetch params: sort: sort
          .then ->
            $scope.$broadcast('scroll.infiniteScrollComplete')
          .catch alert

  .controller 'ItemCtrl', ($scope, $log, $ionicActionSheet, $location) ->
    _.extend $scope,
      showAction: ->
        return true

