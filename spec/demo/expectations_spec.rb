require_relative 'lib/pages/calculator_page'
require_relative 'lib/pages/index_page'
require_relative 'lib/helpers/sinatra_helper'

RSpec.describe 'Expectations' do
  before(:all) do
    SinatraHelper.start
    WatirPump.config.base_url = 'http://localhost:4567'
  end

  after(:all) do
    SinatraHelper.stop
  end

  it 'waits for the result' do
    CalculatorPage.open do |page, _browser|
      page.add(2, 3)
      expect(page.result).to eq 5
    end
  end

  it 'expects collection to be visible and present' do
    IndexPage.open do |page, _browser|
      expect(page.questions).to be_present
      expect(page.questions).to be_visible
    end
  end

  it 'resets the result' do
    CalculatorPage.open do |page, _browser|
      page.sub(5, 2)
      expect(page.result).to eq 3
      page.reset
      expect(page.result_div.text).to eq '-'
    end
  end
end
