# Preview all emails at http://localhost:3000/rails/mailers/tester
class TesterPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/tester/travel
  def travel
    Tester.travel
  end

end
