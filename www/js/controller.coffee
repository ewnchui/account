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

  .controller 'VoteTypeListCtrl', ($scope, collection, $location, $ionicPopup) ->
    _.extend $scope,
      collection: collection
      loadMore: ->
        collection.$fetch()
          .then ->
            $scope.$broadcast('scroll.infiniteScrollComplete')
          .catch alert

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

  .controller 'BreakdownListCtrl', ($scope, sort, collection, $location, $ionicPopup) ->
    _.extend $scope,
      collection: collection
      loadMore: ->
        collection.$fetch params: sort: sort
          .then ->
            $scope.$broadcast('scroll.infiniteScrollComplete')
          .catch alerti

  .controller 'ItemCtrl', ($scope, $log, $ionicActionSheet, $location) ->
    _.extend $scope,
      showAction: ->
        return true

