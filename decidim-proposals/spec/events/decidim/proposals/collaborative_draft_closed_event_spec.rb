# frozen_string_literal: true

require "spec_helper"

describe Decidim::Proposals::CollaborativeDraftClosedEvent do
  include_context "when a simple event"

  let(:event_name) { "decidim.events.proposals.collaborative_draft_closed" }
  let(:resource) { create :collaborative_draft }
  let(:resource_path) { Decidim::ResourceLocatorPresenter.new(resource).path }
  let(:resource_title) { resource.title }
  let(:author) { resource.authors.first }
  let(:author_id) { author.id }
  let(:author_presenter) { Decidim::UserPresenter.new(author) }
  let(:author_path) { author_presenter.profile_path }
  let(:author_name) { author_presenter.name }
  let(:author_nickname) { author_presenter.nickname }
  let(:extra) { { author_id: author_id } }

  context "when the notification is for coauthor users" do
    it_behaves_like "a simple event"

    describe "email_subject" do
      it "is generated correctly" do
        expect(subject.email_subject).to eq("#{author_name} #{author_nickname} closed the #{resource_title} collaborative draft.")
      end
    end

    describe "email_intro" do
      it "is generated correctly" do
        expect(subject.email_intro)
          .to eq(%(<a href="#{author_path}">#{author_name} #{author_nickname}</a> closed the <a href="#{resource_path}">#{resource_title}</a> collaborative draft.))
      end
    end

    describe "email_outro" do
      it "is generated correctly" do
        expect(subject.email_outro)
          .to eq(%(You have received this notification because you are a collaborator of <a href="#{resource_path}">#{resource_title}</a>.))
      end
    end

    describe "notification_title" do
      it "is generated correctly" do
        expect(subject.notification_title)
          .to include(%(<a href="#{author_path}">#{author_name} #{author_nickname}</a> <strong>closed</strong> the <a href="#{resource_path}">#{resource_title}</a> collaborative draft.))
      end
    end
  end

  context "when the notification is for the collaborative draft followers" do
    let(:event_name) { "decidim.events.proposals.collaborative_draft_closed_followers" }

    it_behaves_like "a simple event"

    describe "email_subject" do
      xit "is generated correctly" do
        expect(subject.email_subject).to eq("")
      end
    end

    describe "email_intro" do
      xit "is generated correctly" do
        expect(subject.email_intro)
          .to eq("")
      end
    end

    describe "email_outro" do
      xit "is generated correctly" do
        expect(subject.email_outro)
          .to eq("")
      end
    end

    describe "notification_title" do
      xit "is generated correctly" do
        expect(subject.notification_title)
          .to eq("")
      end
    end
  end
end
