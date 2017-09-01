env = require './env.coffee'
require 'PageableAR'
require 'angular-file-saver'
require 'ng-file-upload'
Promise = require 'bluebird'
_ = require 'lodash'
    
angular.module 'starter.model', ['PageableAR', 'ngFileSaver', 'ngFileUpload']
  
  .factory 'model', (pageableAR, $http, $filter, $log, FileSaver, Upload, $state) ->
    class Vote extends pageableAR.Model
      $urlRoot: "api/vote/"

    class VoteList extends pageableAR.PageableCollection
      model: Vote
      $urlRoot: "api/vote/"

    class VoteType extends pageableAR.Model
      $urlRoot: "api/votetype/"

    class VoteTypeList extends pageableAR.PageableCollection
      model: VoteType
      $urlRoot: "api/votetype/"

    class User extends pageableAR.Model
      $urlRoot: "api/user/"

    class UserList extends pageableAR.PageableCollection
      model: User
      $urlRoot: "api/user/"

    class Breakdown extends pageableAR.Model
      $urlRoot: "api/breakdown/"

      $parse: (res, opts) ->
        if !_.isUndefined(res.InvoiceDate)
          if !_.isNull(res.InvoiceDate)
            res.InvoiceDate = new Date(res.InvoiceDate)
        if !_.isUndefined(res.maintStartDate)
          if !_.isNull(res.maintStartDate)
            res.maintStartDate = new Date(res.maintStartDate)
        if !_.isUndefined(res.completedDate)
          if !_.isNull(res.completedDate)
            res.completedDate = new Date(res.completedDate)
         return res
      
      selStatus: ->
          $http.get 'api/breakdown/getstatus'
            .then (res) ->
               res.data
            .catch $log.error

      selType: ->
          $http.get 'api/breakdown/gettype'
            .then (res) ->
               res.data
            .catch $log.error


    class BreakdownList extends pageableAR.PageableCollection
      model: Breakdown
      $urlRoot: "api/breakdown/"

    Vote: Vote
    VoteList: VoteList 
    VoteType: VoteType
    VoteTypeList: VoteTypeList
    User: User
    UserList: UserList
    Breakdown: Breakdown
    BreakdownList: BreakdownList
