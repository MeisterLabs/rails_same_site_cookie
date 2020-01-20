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
      chrome_with_support?
    end

    def chrome_with_support?
      chromium_based? && chromium_version_from?(67)
    end

    def chromium_based?
      !!/Chrom(e|ium)/.match(user_agent)
    end

    def chromium_version_from?(min_version)
      match = /Chrom[^\/]+\/(\d+)[\.\d]*/.match(user_agent)
      return false unless match

      version = match[1].to_i
      version >= min_version
    end
  end
end
