############
### pug ###
############

module.exports = (gulp, gulpPlugins, config, utils)->
  pugOptions =
    basedir: config.srcDir
    pretty: true

  if config.minify.html and config.env isnt 'develop'
    pugOptions.pretty = false

  # pug
  gulp.task 'pug', ->
    stream = gulp.src utils.createSrcArr 'pug'
    .pipe gulpPlugins.changed config.publishDir, { extension: '.html' }
    .pipe gulpPlugins.plumber errorHandler: utils.errorHandler 'pug'
    .pipe gulpPlugins.data ->
      data = require(config.pugData)(config.env)
      data.env = config.env
      return data
    .pipe gulpPlugins.pug(pugOptions)

    if config.env isnt 'develop'
      stream = stream
      .pipe(gulpPlugins.replace('utf-8', 'shift_jis'))
      .pipe(gulpPlugins.convertEncoding(to: 'euc-jp'))

    stream.pipe gulp.dest config.publishDir
    .pipe gulpPlugins.debug title: gulpPlugins.util.colors.cyan('[pug]:')

  # pugAll
  gulp.task 'pugAll', ->
    stream = gulp.src utils.createSrcArr 'pug'
    .pipe gulpPlugins.plumber errorHandler: utils.errorHandler 'pugAll'
    .pipe gulpPlugins.data ->
      data = require(config.pugData)(config.env)
      data.env = config.env
      return data

    if config.env isnt 'develop'
      stream = stream
      .pipe(gulpPlugins.replace('utf-8', 'shift_jis'))
      .pipe(gulpPlugins.convertEncoding(to: 'euc-jp'))

    stream.pipe gulpPlugins.pug(pugOptions)
    .pipe gulp.dest config.publishDir
    .pipe gulpPlugins.debug title: gulpPlugins.util.colors.cyan('[pugAll]:')
