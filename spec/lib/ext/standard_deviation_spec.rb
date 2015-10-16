require "ext/standard_deviation"

describe "Enumerable#sum" do
  {
    [5, 2, 1] => 8,
    [8, 16, 32, 64] => 120,
    [] => 0,
    [-5, 2] => -3
  }.each do |enum, sum|
    context "given #{enum}" do
      subject { enum.sum }
      it { is_expected.to be sum }
    end
  end
end

describe "Enumerable#mean" do
  {
    [4, 4, 4, 4, 4] => 4,
    [2, 4, 6] => 4,
    [1, 1, 4] => 2,
    [4, 8, 9, 2] => 5.75
  }.each do |enum, mean|
    context "given #{enum}" do
      subject { enum.mean }
      it { is_expected.to be_within(0.1).of mean }
    end
  end
end

describe "Enumerable#sample_variance" do
  {
    [600, 470, 170, 430, 300] => 27_130,
    [4, 4, 4, 4, 4] => 0
  }.each do |enum, sample_variance|
    context "given #{enum}" do
      subject { enum.sample_variance }
      it { is_expected.to be_within(0.1).of sample_variance }
    end
  end
end

describe "Enumerable#standard_deviation" do
  {
    [600, 470, 170, 430, 300] => 164.7,
    [4, 4, 4, 4, 4] => 0
  }.each do |enum, standard_deviation|
    context "given #{enum}" do
      subject { enum.standard_deviation }
      it { is_expected.to be_within(0.1).of standard_deviation }
    end
  end
end
