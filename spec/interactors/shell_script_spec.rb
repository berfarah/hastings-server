describe ShellScript do
  describe ".run" do
    it "reads STDOUT and STDERR" do
      text = {out: "", err: ""}

      described_class.run('echo "Good"; >&2 echo "Bad"') do |out, err|
        text[:out] << out.to_s
        text[:err] << err.to_s
      end

      expect(text[:out]).to eq("Good\n")
      expect(text[:err]).to eq("Bad\n")
    end

    it "streams STDOUT and STDERR instantly" do
      text = {}

      described_class.run('echo "Hello world"; sleep .5') do |out|
        text[:value] = out
        text[:time]  = Time.now
      end

      expect(text[:value]).to eq("Hello world\n")
      expect(text[:time]).to be_within(0.1.second).of(Time.now - 0.5)
    end
  end
end
