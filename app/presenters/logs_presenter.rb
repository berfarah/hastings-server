class LogsPresenter < Presenter
  def by_name
    group_by { |l| l.loggable.try(:name) }
  end

  def by_instance
    group_by(&:instance)
  end

  def empty?
    try(:empty?) || none?
  end
end
