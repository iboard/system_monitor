# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_sysmon_session',
  :secret      => '9bfa370705b51a30ee5b54644acb30337b9bcb1dff12ba0d891115ee470cc10ed9f4a8a8ccf5081dee857e94da12a25277ecec0f20dd066fe894b84f1202818a'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
