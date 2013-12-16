class TasksController < ApplicationController
  expose(:tasks) { Task.all }
  expose(:task, attributes: :task_params)

  def index;   end
  def show;    end
  def new;     end
  def edit;    end

  def create
    if task.save
      redirect_to tasks_path, notice: "Task has been successfully created."
    else
      render :new
    end
  end

  def update
    if task.update_attributes(task_params)
      redirect_to task, notice: "Task has been successfully updated."
    else
      render :edit
    end
  end

  def destroy
    task.destroy
    redirect_to tasks_path, notice: "Task has been successfully removed."
  end

protected
  def task_params
    params.require(:task).permit(:title, :description)
  end
end
