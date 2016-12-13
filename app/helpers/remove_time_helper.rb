module RemoveTimeHelper
    def remove (teacher_id,time)
        @teacher = Teacher.find(params[:teacher_id])
        @teacher.reserved[time] = "Reserved"
        @teacher.save
    end
end
