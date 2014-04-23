When = require "when"
module.exports = (grunt) ->
    CWD = "cwd"
    PROP = "prop"
    FAIL_ON_ERROR = "failOnError"

    grunt.registerMultiTask "git-remover", "Runs git removing unlinked files", (prop, cwd) ->
        done = @async()

        options = {}
        options[CWD] = "."
        options[FAIL_ON_ERROR] = true

        options = this.options(options)

        options[PROP] = prop || options[PROP]
        options[CWD] = cwd || options[CWD]

        grunt.log.verbose.writeflags(options)

        grunt.util.spawn {
            "cmd" : "git"
            "args" : [ "status" ]
            "opts" : {
                "cwd" : options[CWD]
            }
        }, (err, result) ->
            if err
                if options[FAIL_ON_ERROR]
                    done(false)
                    grunt.fail.warn(err)
                else
                    grunt.log.error(err,result)
                    done()
                return

            i = 0

            defereds = []
            promises = []
            arr = result.stdout.split '\n#'

            while (i < arr.length)
                if arr[i].indexOf("\t") == 0
                    fileAction = arr[i].replace("\t", "").match(/\S+/g)

                    # console.log("fileAction", fileAction, fileAction[0])

                    if fileAction[0] == "deleted:"
                        defereds[i] = When.defer()
                        promises.push defereds[i]
                        grunt.util.spawn {
                            "cmd" : "git",
                            "args" : [ "rm", fileAction[1]]
                        }, () ->
                            defereds[i].resolve()
                i++

            result = String(result)
            grunt.log.ok(result)

            if options[PROP]
                grunt.config(options[PROP], result)
            
            When.all(promises).then () ->
                done()
