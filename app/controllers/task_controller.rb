class TaskController < AppController

    set :views, "./app/views"

    # @method: Display a small welcome message
    get '/hello' do
        "Our very first controller"
    end

    # @method: Add a new Task to the DB
    post '/tasks/create' do
        begin
            task = Task.create( self.data(create: true) )
            json_response(code: 201, data: task)
        rescue => e
            json_response(code: 422, data: { error: e.message })
        end
    end

    get '/tasks' do
        tasks = Task.all
        json_response(data: tasks)
    end

    get '/' do
        @tasks = Task.all.map { |task|
          {
            task: task,
            badge: task_status_badge(task.status)
          }
        }
        @i = 1
        erb_response :tasks
    end

    put '/tasks/update/:id' do
        begin
            task = Task.find(self.task_id)
            task.update(self.data)
            json_response(data: { message: "task updated successfully" })
        rescue => e
            json_response(code: 422 ,data: { error: e.message })
        end
    end

    delete '/tasks/destroy/:id' do
        begin
            task = Task.find(self.todo_id)
            task.destroy
            json_response(data: { message: "task deleted successfully" })
        rescue => e
          json_response(code: 422, data: { error: e.message })
        end
    end


    private

    def data(create: false)
        payload = JSON.parse(request.body.read)
        if create
            payload["createdAt"] = Time.now
        end
        payload
    end

    # @helper: retrieve task :id
    def task_id
        params['id'].to_i
    end

    # @helper: format status style
    def task_status_badge(status)
        case status
            when 'CREATED'
                'bg-info'
            when 'ONGOING'
                'bg-success'
            when 'CANCELLED'
                'bg-primary'
            when 'COMPLETED'
                'bg-warning'
            else
                'bg-dark'
        end
    end


end