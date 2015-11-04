RSpec.shared_examples "loggable" do |model|
  let(:m) { create(model) }
  it { is_expected.to respond_to :logs }

  describe "#logs" do
    subject { m.logs }

    describe "#create" do
      it "creates a log associated to #{model}" do
        log = subject.create!(attributes_for(:log))
        expect(log.loggable).to eq m
      end
    end

    describe "#all" do
      it "includes only logs associated with the loggable" do
        subject.create!(attributes_for(:log))
        _other_instance_logs = create(:instance_with_logs)

        expect(subject.all.map(&:loggable_id)).to all(be m.id)
      end
    end
  end
end
