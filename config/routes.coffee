module.exports = 
	routes:
          'GET /api/breakdown/sum':
             controller: 'BreakdownController'
             action: 'sum'
             sort:
               name: 'asc'

          'GET /api/breakdown/getstatus':
             controller: 'BreakdownController'
             action: 'getStatus'
             sort:
               name: 'asc'

          'GET /api/breakdown/gettype':
             controller: 'BreakdownController'
             action: 'getType'
             sort:
               name: 'asc'
