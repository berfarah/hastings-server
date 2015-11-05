whitelist = ENV["EMAIL_WHITELIST"].try(:split, /[,\s]+/) || []
Rails.application.config.email_whitelist = whitelist
Rails.application.config.email_whitelist_regex = /(#{Regexp.union(whitelist)})$/
