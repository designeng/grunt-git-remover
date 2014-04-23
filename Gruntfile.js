/*
 * grunt-git-status
 * https://github.com/nyfagel/grunt-git-status
 * Forked from https://github.com/mikaelkaron/grunt-git-describe
 *
 * Copyright (c) 2013 Ny fågel
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

		"git-status-delete": {
			"me" : {
			}
		}

	});

	grunt.loadTasks("tasks");
	grunt.loadNpmTasks("grunt-contrib-jshint");
	grunt.registerTask("default", [ "jshint", "git-status-delete" ]);

};
