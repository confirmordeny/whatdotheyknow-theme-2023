require_relative '../spec_helper'

RSpec.describe RequestMailer do

  describe "when mail to a user through RequestMailer" do

    let(:info_request) { FactoryBot.create(:info_request) }
    let(:mail) { RequestMailer.overdue_alert(info_request, info_request.user) }

    before do
      allow(AlaveteliConfiguration).to receive(:site_name).and_return("Test")
    end

    it "appends the custom footer after the site team sign-off" do
      expected = <<-EOF.strip_heredoc
        -- the Test team

        --------------------------------------------------------------------------------

        WhatDoTheyKnow is a project of mySociety run by a small team of staff and
        dedicated volunteers.
        EOF
      expect(mail.body.to_s.gsub(/\r/, '')).to include(expected)
    end

  end

end
