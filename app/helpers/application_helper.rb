module ApplicationHelper
    
    def editRow(produce)
        render 'form', produce: produce
    end
end
