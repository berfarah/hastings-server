require "ext/parse_time"

describe "Integer#human_time" do
  {
    90    => "1 minute and 30 seconds",
    150   => "2 minutes and 30 seconds",
    5_400 => "1 hour and 30 minutes",
    5_405 => "1 hour, 30 minutes and 5 seconds",
    7_200 => "2 hours"
  }.each do |seconds, text|
    context "given #{seconds} seconds" do
      subject { seconds.human_time }
      it { is_expected.to eq text }
    end
  end
end
