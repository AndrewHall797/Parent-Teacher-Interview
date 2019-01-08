#Help method to remvoe slected time slot
module RemoveTimeHelper
    def remove (teacher_id,time)
        @teacher = Teacher.find(params[:teacher_id])#Fidn teacher
        @teacher.reserved[time] = "Reserved"#Resevere slected time
        @teacher.save
    end
end
