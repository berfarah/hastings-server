describe LogsSearch do
  def search(**args)
    described_class.new(**args).search
  end

  def import(*args)
    LogsIndex.import!(*args)
  end

  before { LogsIndex.purge! }

  describe "#from, #to" do
    let(:task) { create(:task) }
    let(:instance) { create(:instance, task: task) }

    before do
      @twodaysago = create(:log, loggable: instance)
      @twodaysago.update_attributes(created_at: 2.days.ago)
      @yesterday = create(:log, loggable: instance)
      @yesterday.update_attributes(created_at: 1.day.ago)
      @today = create(:log, loggable: instance)
      import
    end

    after do
      [@twodaysago, @yesterday, @today].each(&:destroy)
    end

    specify { expect(search(to: 10.minutes.ago).load).to match_array([@twodaysago, @yesterday]) }
    specify { expect(search(from: 10.minutes.ago).load).to match_array([@today]) }
    specify { expect(search(from: 2.day.ago, to: 10.minutes.ago)).to match_array([@yesterday]) }
    specify { expect(search(to: 2.days.ago)).to match_array([@twodaysago]) }
  end
end
