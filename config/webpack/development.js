process.env.NODE_ENV = process.env.NODE_ENV || 'development'

const environment = require('./environment')

module.exports = environment.toWebpackConfig()

config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
