# frozen_string_literal: true

require 'rspec'
require_relative 'safelyx'

RSpec.describe Safelyx::Client do
  let(:key_code) { ENV.fetch('TEST_KEY_CODE', nil) }
  let(:client) { described_class.new(key_code) }

  describe '#check_link' do
    it 'can check a link' do
      result = client.check_link('example.com')

      expect(result[:url]).to eq('https://example.com')
      expect([-2, *(8..10)]).to include(result[:result])
      expect(result[:result_text]).not_to be_empty
      expect(result[:date]).not_to be_empty

      analysis = result[:analysis]
      expect(analysis[:domain_reputation]).not_to be_empty
      expect(analysis[:source_code]).not_to be_empty
      expect(analysis[:anti_virus]).not_to be_empty

      expect(result[:checks_remaining]).to be >= 0
    end
  end

  describe '#check_email' do
    it 'can check an email' do
      result = client.check_email('help@safelyx.com')

      expect(result[:email]).to eq('help@safelyx.com')
      expect([-2, *(8..10)]).to include(result[:result])
      expect(result[:result_text]).not_to be_empty
      expect(result[:date]).not_to be_empty

      analysis = result[:analysis]
      expect(analysis[:address]).not_to be_empty
      expect(analysis[:domain_reputation]).not_to be_empty
      expect(analysis[:mx_records]).not_to be_empty

      expect(result[:checks_remaining]).to be >= 0
    end
  end

  describe '#check_message' do
    it 'can check a message' do
      result = client.check_message('Hello, world!')

      expect(result[:message]).to eq('Hello, world!')
      expect([-2, *(8..10)]).to include(result[:result])
      expect(result[:result_text]).not_to be_empty
      expect(result[:date]).not_to be_empty

      analysis = result[:analysis]
      expect(analysis[:content]).not_to be_empty
      expect(analysis[:sentiment]).not_to be_empty
      expect(analysis[:links]).to be_an(Array)
      expect(analysis[:emails]).to be_an(Array)

      expect(result[:checks_remaining]).to be >= 0
    end
  end

  describe '#check_image' do
    it 'can check an image' do
      image_url = 'https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_272x92dp.png'
      result = client.check_image(image_url)

      expect(result[:image_url]).to eq(image_url)
      expect([-2, *(8..10)]).to include(result[:result])
      expect(result[:result_text]).not_to be_empty
      expect(result[:date]).not_to be_empty

      analysis = result[:analysis]
      expect(analysis[:description]).not_to be_empty

      link = analysis[:link]
      expect(link[:url]).not_to be_empty
      expect(link[:result]).to be >= -1
      expect(link[:date]).not_to be_empty

      link_analysis = link[:analysis]
      expect(link_analysis[:domain_reputation]).not_to be_empty
      expect(link_analysis[:source_code]).not_to be_empty
      expect(link_analysis[:anti_virus]).not_to be_empty

      expect(result[:checks_remaining]).to be >= 0
    end
  end
end
