# frozen_string_literal: true

module RailsSameSiteCookie
  class UserAgentChecker
    attr_accessor :user_agent

    def initialize(user_agent = nil)
      @user_agent = user_agent
    end

    def send_same_site_none?
      return false if user_agent.blank?

      same_site_supported?
    end

    private

    def same_site_supported?
      chrome_with_support? || firefox_with_support?
    end

    def chrome_with_support?
      chromium_based? && chromium_version_from?(67)
    end

    def firefox_with_support?
      is_firefox? && firefox_version_from?(61)
    end

    def chromium_based?
      !!/Chrom(e|ium)/.match(user_agent)
    end

    def is_firefox?
      !!/Firefox/.match(user_agent)
    end

    def chromium_version_from?(min_version)
      browser_version_from?(/Chrom[^\/]+/, min_version)
    end

    def firefox_version_from?(min_version)
      browser_version_from?(/Firefox/, min_version)
    end

    def browser_version_from?(browser_regex, min_version)
      match = /#{browser_regex}\/(\d+)[\.\d]*/.match(user_agent)
      return false unless match

      version = match[1].to_i
      version >= min_version
    end
  end
end
