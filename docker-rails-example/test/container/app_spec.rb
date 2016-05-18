require 'spec_helper'

describe server(:app) do
  describe http('http://app:8080') do
    it "responds OK 200" do
      expect(response.status).to eq(200)
    end
  end
  describe http('http://app:8080/_status/healthz') do
    it "responds OK 200" do
      expect(response.status).to eq(200)
    end
  end
end
