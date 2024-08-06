require "rails_helper"

RSpec.describe CompanyMailer, type: :mailer do
  describe 'approval_email' do
    let(:company) { create(:random_company) }
    let(:code) { 'unique_code' }
    let(:mail) { described_class.with(company: company, code: code).approval_email.deliver_now }

    it 'renders the headers' do
      expect(mail.subject).to eq('Your Company has been Approved')
      expect(mail.to).to eq([company.users.find_by(role_id: 3).email])
      expect(mail.from).to eq(['no-reply@example.com'])
    end

    it 'renders the body' do
      # Check for specific parts of the HTML content
      expect(mail.body.encoded).to include("Dear #{company.users.find_by(role_id: 3).name},")
      expect(mail.body.encoded).to include("We are pleased to inform you that your company, #{company.company_name}, has been approved.")
      expect(mail.body.encoded).to include("Your approval code is: #{code}")
      expect(mail.body.encoded).to include("Thank you for your cooperation.")
      expect(mail.body.encoded).to include("Best regards,<br>")
      expect(mail.body.encoded).to include("The Team")
    end
  end
end
