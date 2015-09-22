# Extension to add mean, sum, variance and deviation
module Enumerable
  def sum
    inject(0, :+)
  end

  def mean
    sum / length.to_f
  end

  def sample_variance
    inject(0) { |a, e| a + (e - mean)**2 } / (length - 1).to_f
  end

  def standard_deviation
    Math.sqrt sample_variance
  end
end
