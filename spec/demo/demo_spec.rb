require_relative 'lib/pages/index_page'
require_relative 'lib/pages/calculator_page'
require_relative 'lib/helpers/sinatra_helper'

RSpec.describe 'Demo Sinatra App' do
  before(:all) do
    SinatraHelper.start
    WatirPump.config.base_url = 'http://localhost:4567'
  end

  after(:all) do
    SinatraHelper.stop
  end

  it 'page method call' do
    IndexPage.open do |page, browser|
      page.goto_contact
      expect(browser.url).to include('contact.html')
    end
  end

  it 'URL params' do
    CalculatorPage.open(query: { operand1: 2, operand2: 4 }) do |_page, browser|
      expect(browser.url).to include('operand1=2&operand2=4')
    end
  end
end
