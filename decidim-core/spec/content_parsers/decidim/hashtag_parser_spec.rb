# frozen_string_literal: true

require "spec_helper"

module Decidim
  describe ContentParsers::HashtagParser do
    let(:organization) { create(:organization) }
    let(:hashtag) { create(:hashtag, organization: organization) }
    let(:parser) { described_class.new(content) }

    before do
      Thread.current[:organization] = organization
    end

    context "when hashtagging a hashtag present" do
      let(:content) { "This text contains a hashtag present on DB: ##{hashtag.name}" }

      it "rewrites the hashtag" do
        expect(parser.rewrite).to eq("This text contains a hashtag present on DB: #{hashtag.to_global_id}")
      end

      it "returns the correct metadata" do
        expect(parser.metadata).to be_a(Decidim::ContentParsers::HashtagParser::Metadata)
        expect(parser.metadata.hashtags).to eq([hashtag])
      end
    end

    context "when hashtagging multiple hashtag presents" do
      let(:hashtag2) { create(:hashtag, organization: organization) }
      let(:content) { "This text contains multiple hashtag presents: ##{hashtag.name} and ##{hashtag2.name}" }

      it "rewrites all hashtags" do
        expect(parser.rewrite).to include("This text contains multiple hashtag presents: #{hashtag.to_global_id} and #{hashtag2.to_global_id}")
      end

      it "returns the correct metadata" do
        expect(parser.metadata).to be_a(Decidim::ContentParsers::HashtagParser::Metadata)
        expect(parser.metadata.hashtags).to eq([hashtag, hashtag2])
      end
    end

    context "when hashtagging a non created hashtag" do
      let(:hashtag3) { create(:hashtag, organization: organization) }
      let(:content) { "This text hashtagiing a non created hashtag: ##{hashtag3.name}" }

      it "creates the hashtag and rewrite the hashtag" do
        expect(parser.rewrite).to include( "This text hashtagiing a non created hashtag: #{hashtag3.to_global_id}")
      end

      it "returns correct metadata" do
        expect(parser.metadata).to be_a(Decidim::ContentParsers::HashtagParser::Metadata)
        expect(parser.metadata.hashtags).to eq([hashtag3])
      end
    end
  end
end
