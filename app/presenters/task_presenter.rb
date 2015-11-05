class TaskPresenter < Presenter
  attr_reader :logs

  def initialize(task, logs = nil)
    logs && @logs = LogsPresenter.new(logs)
    super(task)
  end

  def logs
    @logs || __getobj__.logs
  end
end
