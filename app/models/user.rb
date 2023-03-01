# A user should be able to create a task that is well described with due dates.
# A user should be able to update the status of their task.

class User < ActiveRecord::Base
    has_many :tasks
end