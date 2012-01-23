# Be sure to restart your server when you modify this file.

#I4pc::Application.config.session_store :cookie_store, key: '_i4pc_session'

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rails generate session_migration")
# I4pc::Application.config.session_store :active_record_store

I4pc::Application.config.session_store :mem_cache_store, {
  memcache_server: ['127.0.0.1:11211'],
  key: '_i4pc_session',
  namespace: 'i4pc',
}
