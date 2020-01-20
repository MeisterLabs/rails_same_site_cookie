# Fork of RailsSameSiteCookie

This is a fork of the gem [RailsSameSiteCookie](https://github.com/pschinis/rails_same_site_cookie/). It contains three major changes.
 
 First, the user_agent_parser gem is removed because of slow performance.
 
 Second, it uses whitelisting compatible browser instead of blacklisting incompatible browser for SameSite=blank. For now only Chrome 67+ is checked.

Third, only set SameSite=None for ssl requests. Otherwise leave it blank. For non-ssl requests SameSite=None doesn't work because the secure flag is required too. This is mainly relevant for non-ssl development servers.
