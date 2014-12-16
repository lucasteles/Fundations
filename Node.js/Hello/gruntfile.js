// Generated by CoffeeScript 1.8.0
(function() {
  module.exports = function(grunt) {
    var fs, isModified;
    fs = require('fs');
    isModified = function(filepath) {
      var modified, now;
      now = new Date();
      modified = fs.statSync(filepath).mtime;
      return (now - modified) < 10000;
    };
    grunt.initConfig({
      pkg: grunt.file.readJSON('package.json'),
      coffee: {
        options: {
          sourceMap: true,
          bare: true,
          force: true
        },
        all: {
          expand: true,
          cwd: 'src/coffee/',
          src: '**/*.coffee',
          dest: 'compiled',
          ext: '.js'
        },
        modified: {
          expand: true,
          cwd: 'src/coffee/',
          src: '**/*.coffee',
          dest: 'compiled',
          ext: '.js',
          filter: isModified
        }
      },
      coffeelint: {
        options: {
          force: true
        },
        all: {
          expand: true,
          cwd: 'src/coffee/',
          src: '**/*.coffee'
        },
        modified: {
          expand: true,
          cwd: 'src/coffee/',
          src: '**/*.coffee',
          filter: isModified
        }
      },
      nodemon: {
        dev: {
          script: 'compiled/index2.js'
        }
      },
      watch: {
        coffeescript: {
          files: ['src/**/*.coffee'],
          tasks: ['coffeelint:modified', 'coffee:modified']
        }
      },
      concurrent: {
        dev: {
          tasks: ['nodemon', 'watch'],
          options: {
            logConcurrentOutput: true
          }
        }
      }
    });
    grunt.loadNpmTasks('grunt-concurrent');
    grunt.loadNpmTasks('grunt-coffeelint');
    grunt.loadNpmTasks('grunt-contrib-coffee');
    grunt.loadNpmTasks('grunt-contrib-watch');
    grunt.loadNpmTasks('grunt-nodemon');
    return grunt.registerTask('default', ['coffeelint:all', 'coffee:all', 'concurrent:dev']);
  };

}).call(this);