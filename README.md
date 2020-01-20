# Fork of RailsSameSiteCookie

This is a fork of the gem [RailsSameSiteCookie](https://github.com/pschinis/rails_same_site_cookie/). It contains two major changes.
 
 First, the user_agent_parser gem is removed because of slow performance.
 
 Second, it uses whitelisting compatible browser instead of blacklisting incompatible browser for SameSite=blank. For now only Chrome 67+ is checked.
