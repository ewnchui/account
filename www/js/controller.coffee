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
  .controller 'VoteCtrl', ($scope, model, $location, $log, $ionicModal, votetypeList) ->
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
      votetypeList : votetypeList.models
      model: model
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
      loadMore: ->
        collection.$fetch()
          .then ->
            $scope.$broadcast('scroll.infiniteScrollComplete')
          .catch alert
  .controller 'ItemCtrl', ($scope, $log, $ionicActionSheet, $location) ->
    _.extend $scope,
      showAction: ->
        return true

