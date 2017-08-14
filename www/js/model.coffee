env = require './env.coffee'
require 'PageableAR'
require 'angular-file-saver'
require 'ng-file-upload'
		
angular.module 'starter.model', ['PageableAR', 'ngFileSaver', 'ngFileUpload']
	
	.factory 'model', (pageableAR, $http, $filter, $log, FileSaver, Upload, $state) ->
		
		class AccountList extends pageableAR.PageableCollection
			$urlRoot: "api/db/me"		
	
		AccountList:	AccountList
