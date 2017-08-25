env = require './env.coffee'
require 'PageableAR'
require 'angular-file-saver'
require 'ng-file-upload'
    
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
