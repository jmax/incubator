class TasksController < InheritedResources::Base
  actions :all

  def create
    create! { tasks_path }
  end

protected
  def permitted_params
    params.permit(task: [:title, :description])
  end
end
