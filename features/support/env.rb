require 'rubygems'
require 'bundler/setup'
require "capybara/cucumber"
require "rspec"
require 'capybara/poltergeist'
require 'selenium-webdriver'
require 'bddfire'

BS_USSERNAME = ""
BS_KEY = ""
SAUCE_USERNAME = ""
SAUCE_KEY = ""


Capybara.configure do |config|

  config.run_server = false
  config.default_driver = (ENV['DRIVER'] || 'selenium').to_sym
  config.javascript_driver = config.default_driver
  config.default_selector = :xpath
  config.default_wait_time = 60
end

Capybara.register_driver :selenium do |app|

  profile = Selenium::WebDriver::Firefox::Profile.new
  Capybara::Selenium::Driver.new(app, :profile => profile)
end

Capybara.register_driver :poltergeist do |app|

    options = {
        :js_errors => true,
        :timeout => 120,
        :debug => false,
        :phantomjs_options => ['--load-images=no', '--disk-cache=false'],
        :inspector => true,

    }

    Capybara::Poltergeist::Driver.new(app, options)
end

Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(app, :browser => :chrome)
end

Capybara.register_driver :browserstack do |app|
    job_name = "Cucumber-Tests running in the BrowserStack - #{Time.now.strftime '%Y-%m-%d %H:%M'}"
    browser =  ENV['BS_BROWSER']  || 'Safari'
    version =  ENV['BS_VERSION']  || '8'
    platform = ENV['BS_PLATFORM'] || 'MAC'
    capabilities = {:browserName => browser, :version => version, :platform => platform, :name => job_name}
    Capybara::Selenium::Driver.new(app,
      :browser => :remote,
      :desired_capabilities => capabilities,
      :url => "http://BS_USERNAME:BS_KEY@hub.browserstack.com/wd/hub"
    )
end

Capybara.register_driver :sauce do |app|
  job_name = "Cucumber-Tests - #{Time.now.strftime '%Y-%m-%d %H:%M'}"
  browser =  ENV['SAUCE_BROWSER']  || 'internet explorer'
  version =  ENV['SAUCE_VERSION']  || '10.0'
  platform = ENV['SAUCE_PLATFORM'] || 'Windows 8'
  duration = 7200
  capabilities = {:browserName => browser, :version => version, :platform => platform, :name => job_name, "max-duration" => duration}
  puts "Running #{job_name} on SauceLabs with #{browser} #{version} on #{platform}"
  Capybara::Selenium::Driver.new(app,
    :browser => :remote,
    :desired_capabilities => capabilities,
    :url => "http://SAUCE_USERNAME:SAUCE_KEY@ondemand.saucelabs.com:80/wd/hub")
end
