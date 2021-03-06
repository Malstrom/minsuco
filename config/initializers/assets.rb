# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.
Rails.application.config.assets.paths << Rails.root.join('node_modules')

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
# Rails.application.config.assets.precompile += %w( admin.js admin.css )

Rails.application.config.assets.precompile += %w(
 races.css races.js
 dashboard.css dashboard.js
 subscriptions.css subscriptions.js
 devise/sessions.css devise/sessions.js
 devise/registrations.css devise/registrations.js
 devise/passwords.css devise/passwords.js
 users.css users.js
 attendees.css attendees.js
 registrations.css registrations.js
 Chart.bundle.js chartkick.js
 cable.js
 events.css events.js )