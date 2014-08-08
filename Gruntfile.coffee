
module.exports = (grunt) ->
  grunt.loadNpmTasks 'grunt-mocha-test'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-peg'

  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'

    coffee:
      compile:
        files:
          'lib/index.js': 'src/index.coffee'

    peg:
      parser:
        src: 'src/parser.pegjs'
        dest: 'lib/parser.js'
        options:
          exportVar: 'module.exports'

    watch:
      coffee:
        files: [ 'src/index.coffee' ]
        tasks: [ 'coffee' ]
      parser:
        files: [ 'src/parser.pegjs' ]
        tasks: [ 'peg:parser' ]

    mochaTest:
      test:
        options:
          reporter: 'spec'
          require: [
            'coffee-script'
          ]
        src: [ 'spec/**/*.coffee' ]

  grunt.registerTask 'test', [ 'mochaTest' ]
  grunt.registerTask 'compile', [ 'coffee' ]
  grunt.registerTask 'default', [ 'compile', 'peg' ]
