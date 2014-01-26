rs.initiate({"_id" : "<%= replSet %>","members" : [{"_id" : 0,"host" : "<%= hostName %>:<%= port %>","priority" : 50}]})
