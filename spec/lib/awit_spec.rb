require 'spec_helper'

describe Awit do

  it 'has a version number' do
    expect(Awit::VERSION).not_to be nil
  end

  describe ".configure" do
    let(:auth_token_cb) { -> { [100...200].sample } }

    it "sets configuration" do
      Awit.configure do |c|
        c.auth_token = auth_token_cb
        c.content_type = "content-type"
        c.accept = "Accept"
      end

      expect(Awit.auth_token).to eq auth_token_cb
      expect(Awit.content_type).to eq "content-type"
      expect(Awit.accept).to eq "Accept"
    end
  end

  [:content_type, :accept].each do |method_name|
    describe ".#{method_name}" do
      it "defaults to 'application/json'" do
        expect(described_class.send(method_name)).to eq "application/json"
      end
    end
  end

  describe "rest actions" do
    let(:auth_token_cb) { -> { 2 } }
    let(:body) { {some: "body"} }
    let(:response) { double(Typhoeus::Response) }

    before do
      Awit.configure do |config|
        config.auth_token = auth_token_cb
      end
    end

    [:get, :delete].each do |http_method|
      describe ".#{http_method}" do
        it "delegates `#{http_method}` work to Typhoeus" do
          expect(Typhoeus).to receive(http_method).with("url.com", {
            headers: {
              "content-type" => "application/json",
              Accept: "application/json",
              AUTHORIZATION: "Bearer 2",
            },
          }).and_return(response)

          described_class.send(http_method, "url.com")
        end
      end
    end

    [:post, :put, :patch].each do |http_method|
      describe ".#{http_method}" do
        it "delegates `#{http_method}` work to Typhoeus" do
          expect(Typhoeus).to receive(http_method).with("url.com", {
            body: body,
            headers: {
              "content-type" => "application/json",
              Accept: "application/json",
              AUTHORIZATION: "Bearer 2",
            },
          }).and_return(response)

          described_class.send(http_method, "url.com", body: body)
        end
      end
    end
  end

end
