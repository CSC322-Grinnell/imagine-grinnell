module ApplicationHelper
  def edit_row(produce)
    render 'form', produce: produce
  end
end
