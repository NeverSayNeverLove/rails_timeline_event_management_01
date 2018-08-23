RSpec.describe Event, type: :model do
  context "associations" do
    it { should have_many :comments}
  end

  let(:valid_attributes) {
    {
      place: "Ha Noi",
      time_from: Time.now,
      time_to: Time.now + 1000,
      remind: true, importance: "normal",
      description: "ok"
    }
  }
  
  context "validations event" do
    let(:event) { Event.new(valid_attributes) }

    before do
      Event.create(valid_attributes)
    end

    it "requires an description" do 
      expect(event).to validate_presence_of :description
    end
  end
end
