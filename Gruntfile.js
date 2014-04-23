/*
 * grunt-git-remover
 * https://github.com/designeng/grunt-git-remover
 * Forked from https://github.com/nyfagel/grunt-git-status
 *
 * Copyright (c) 2014 designeng
 * Licensed under the MIT license.
 */

"use strict";

module.exports = function (grunt) {
	grunt.initConfig({
		"jshint": {
			"all": [
				"Gruntfile.js",
				"tasks/*.js"
			],
			"options": {
				"jshintrc": ".jshintrc"
			}
		},

		"git-remover": {
			"me" : {
			}
		}

	});

	grunt.loadTasks("tasks");
	grunt.loadNpmTasks("grunt-contrib-jshint");
	grunt.registerTask("default", [ "jshint", "git-remover" ]);

};
