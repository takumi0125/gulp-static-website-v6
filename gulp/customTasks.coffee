####################
### custom tasks ###
####################

module.exports = (gulp, gulpPlugins, config, utils)->
  # indexSprites
  # utils.createSpritesTask 'indexSprites', "#{config.assetsDir}/img/index", "#{config.assetsDir}/css", 'sprites', '../img/index/sprites.png', true

  # lib.js
  utils.createJsConcatTask(
    'concatLibJs'
    [
      "#{config.srcDir}/#{config.assetsDir}/js/_lib/mobile-detect.min.js"
      "#{config.srcDir}/#{config.assetsDir}/js/_lib/dat.gui.min.js"
      "#{config.srcDir}/#{config.assetsDir}/js/_lib/stats.min.js"
      "#{config.srcDir}/#{config.assetsDir}/js/_lib/es6-promise.auto.min.js"
      "#{config.srcDir}/#{config.assetsDir}/js/_lib/TweenMax.min.js"
      "#{config.srcDir}/#{config.assetsDir}/js/_lib/webfontloader.js"
      "#{config.srcDir}/#{config.assetsDir}/js/_lib/underscore-min.js"
      "#{config.srcDir}/#{config.assetsDir}/js/_lib/axios.js"
    ]
    "#{config.publishDir}/#{config.assetsDir}/js"
    'lib'
  )

  # contents js
  utils.createWebpackJsTask(
    "indexJs"
    [ "#{config.srcDir}/#{config.assetsDir}/js/_index/init.js" ]
    [
      "#{config.srcDir}/#{config.assetsDir}/js/_utils/**/*"
      "#{config.srcDir}/#{config.assetsDir}/js/_index/**/*"
    ]
    "#{config.publishDir}/#{config.assetsDir}/js"
    'index'
  )
