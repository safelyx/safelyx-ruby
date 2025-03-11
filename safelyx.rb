# frozen_string_literal: true

require 'net/http'
require 'json'
require 'uri'

module Safelyx
  class Client
    def initialize(key_code = nil)
      @key_code = key_code
      @http_timeout = 10
    end

    def check_link(link)
      payload = {
        link: link,
        key_code: @key_code
      }

      make_request('https://safelyx.com/safe-link-checker', payload)
    end

    def check_email(email)
      payload = {
        email: email,
        key_code: @key_code
      }

      make_request('https://safelyx.com/safe-email-checker', payload)
    end

    def check_message(message, skip_link_and_email_checks: false)
      payload = {
        message: message,
        skip_link_and_email_checks: skip_link_and_email_checks,
        key_code: @key_code
      }

      make_request('https://safelyx.com/safe-message-checker', payload)
    end

    def check_image(image_url)
      payload = {
        image_url: image_url,
        key_code: @key_code
      }

      make_request('https://safelyx.com/safe-image-checker', payload)
    end

    private

    def make_request(url, payload)
      uri = URI(url)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = uri.scheme == 'https'
      http.read_timeout = @http_timeout

      request = Net::HTTP::Post.new(uri)
      request['Content-Type'] = 'application/json; charset=utf-8'
      request['Accept'] = 'application/json; charset=utf-8'
      request.body = payload.to_json

      response = http.request(request)
      JSON.parse(response.body, symbolize_names: true)
    rescue StandardError => e
      raise "Request failed: #{e.message}"
    end
  end
end
