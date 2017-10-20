Promise = require 'promise'

module.exports = 
  getStartDate: () ->
    currYear = new Date().getFullYear()
    return new Date("4/1/#{currYear}")

  getEndDate: () ->
    currYear = new Date().getFullYear()
    return new Date("3/31/#{currYear + 1}")
