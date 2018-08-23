RSpec.describe User, type: :model do
  context "associations" do
    it { is_expected.to have_many :events}
  end

  let(:valid_attributes) {
    {
      email: "dang.nhu.thuy@framgia.com",
      password: "123456",
      password_confirmation: "123456",
      role: 2,
      confirmation_token: nil,
      confirmation_sent_at: Time.now,
      confirmed_at: Time.now
    }
  }

  context "validations email" do
    let(:user) { User.new(valid_attributes) }

    before do
      User.create(valid_attributes)
    end

    it "requires an email" do 
      expect(user).to validate_presence_of :email
    end

    it "requires an password" do 
      expect(user).to validate_presence_of :password
    end

    it "requires a unique email" do
      expect(user).to validate_uniqueness_of(:email).ignoring_case_sensitivity
    end

    it "requires a unique email (case insensitive)" do
      user.email = "DANG.NHU.THUY@FRAMGIA.COM"
      expect(user).to validate_uniqueness_of(:email).ignoring_case_sensitivity
    end

    it "requires the email address to look like an email" do
      user.email = "dangnhuthuy"
      expect(user).to_not be_valid
    end

    it "length of password" do
      expect(user).to validate_length_of(:password).
        is_at_least(6).
        on(:create)
    end
  end
end
