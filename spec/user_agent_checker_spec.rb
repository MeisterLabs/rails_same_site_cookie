RSpec.describe RailsSameSiteCookie::UserAgentChecker do

  it "always returns false if user agent is null or blank" do
    uac = described_class.new(nil)
    expect(uac.send_same_site_none?).to be false

    uac.user_agent = ''
    expect(uac.send_same_site_none?).to be false
  end

  it "returns false for Chrome under 67" do
    uac = described_class.new("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3334.0 Safari/537.36")
    expect(uac.send_same_site_none?).to be false
  end

  it "returns true for Chrome above 67" do
    uac = described_class.new("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.130 Safari/537.36")
    expect(uac.send_same_site_none?).to be true

    uac.user_agent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.0.0 Safari/537.36"
    expect(uac.send_same_site_none?).to be true
  end

  it "returns false for UC browsers under 12.13.2" do
    uac = described_class.new("Mozilla/5.0 (Linux; U; Android 6.0.1; zh-CN; F5121 Build/34.0.A.1.247) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/40.0.2214.89 UCBrowser/11.5.1.944 Mobile Safari/537.36")
    expect(uac.send_same_site_none?).to be false

    uac.user_agent = "Mozilla/5.0 (Linux; U; Android 6.0.1; zh-CN; F5121 Build/34.0.A.1.247) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/40.0.2214.89 UCBrowser/12.12.3.944 Mobile Safari/537.36"
    expect(uac.send_same_site_none?).to be false

    uac.user_agent = "Mozilla/5.0 (Linux; U; Android 6.0.1; zh-CN; F5121 Build/34.0.A.1.247) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/40.0.2214.89 UCBrowser/12.13.1.944 Mobile Safari/537.36"
    expect(uac.send_same_site_none?).to be false
  end

  it "returns false for UC browsers greater than or equal to 12.13.2" do
    uac = described_class.new("Mozilla/5.0 (Linux; U; Android 6.0.1; zh-CN; F5121 Build/34.0.A.1.247) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/40.0.2214.89 UCBrowser/12.13.2.1 Mobile Safari/537.36")
    expect(uac.send_same_site_none?).to be false
  end

  it "returns false for others" do
    uac = described_class.new("Opera/9.80 (Windows NT 6.1; WOW64) Presto/2.12.388 Version/12.18")
    expect(uac.send_same_site_none?).to be false

    uac.user_agent = "Mozilla/5.0 (Windows NT 6.1; WOW64; rv:64.0) Gecko/20100101 Firefox/64.0"
    expect(uac.send_same_site_none?).to be false

    uac.user_agent = "Mozilla/5.0 (Windows NT 6.1; WOW64; Trident/7.0; AS; rv:11.0) like Gecko"
    expect(uac.send_same_site_none?).to be false
  end
end
