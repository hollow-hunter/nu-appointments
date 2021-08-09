const { environment } = require('@rails/webpacker')
const { VueLoaderPlugin } = require('vue-loader')
const vue = require('./loaders/vue')
const webpack = require('webpack')

environment.plugins.prepend('VueLoaderPlugin', new VueLoaderPlugin())
environment.loaders.prepend('vue', vue)
environment.plugins.prepend(
  "Provide",
  new webpack.ProvidePlugin({
    $: "jquery",
    jQuery: "jquery",
    jquery: "jquery",
    "window.Tether": "tether",
    Popper: ["popper.js", "default"] // for Bootstrap 4
  })
);
const customConfig = require('./custom-config')
// before module export.
environment.config.merge(customConfig)

module.exports = environment
