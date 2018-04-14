# Pre-configurations (Change if you want an awesome difficulty assessment)
require_relative 'config/application'

# Your Code begins from this line onwards #

class Todo

	## Adds new task and display updated list
	def self.add(desc, status)
		Task.create(description: desc.capitalize, status: status.capitalize)
		system "clear" or system "cls"
		puts "Task added."
		Todo.list
	end

	## Displays an indexed list of tasks
	def self.list
		list = Task.all
		puts <<~STR
		No.	Description		Status
		===	===========		======
		STR
		list.each_with_index do |task, index|
			puts "#{index+1}.	#{task.description}		#{task.status}"
		end
	end

	## Updates the task(s) with varifying methods
	def self.update(index, desc, status)
		list = []
		samples = Task.all
		samples.each do |task|
			list << task
		end

		# Updates all the status of the tasks
		# method: --update all status (status)
		if index == "all" || index == "All"
			samples.each do |update|
				update.update(status: status.capitalize)
				puts "All tasks status updated."
				system "clear" or system "cls"
				Todo.list
			end
		else
			index = index.to_i

			if index <= list.length
				task = list[index-1]
				# Updates nothing if input is nil
				if desc == nil && status == nil
					puts "Nothing updated."
				# Updates the status only
				# method: --update (index) status (status)
				elsif desc == "status" || desc == "Status"
					task.update(status: status.capitalize)
					puts "Task #{index} status updated."
					system "clear" or system "cls"
					Todo.list
				# Updates the description only
				# method: --update (index) description (description)
				elsif desc == "description" || desc == "Description"
					task.update(description: status.capitalize)
					puts "Task #{index} description updated."
					system "clear" or system "cls"
					Todo.list
				# Updates the tasks at index with new description and new status
				else
					task.update(description: desc.capitalize, status: status.capitalize)
					puts "Task #{index} updated."
					system "clear" or system "cls"
					Todo.list
				end
			else
				puts "Task #{index} is not found. Are you sure that this is the right task number?"
			end
		end
	end

	## Removes the task(s) 
	def self.remove(index)
		list = []
		samples = Task.all
		samples.each do |task|
			list << task
		end

		# Deletes all tasks
		# method: --remove all 
		if index == "all" || index == "All"
			Task.destroy_all
			puts "All tasks deleted."
			system "clear" or system "cls"
			Todo.list
		# Deletes the task at index
		else
			index = index.to_i

			if index <= list.length
				del = list[index-1]
				del.delete
				system "clear" or system "cls"
				puts "Task #{index} deleted."
				Todo.list
			else
				puts "Task #{index} is not found. Are you sure that this is the right task number?"
			end
		end
	end



end

command = ARGV[0]
value1 = ARGV[1]
value2 = ARGV[2]
value3 = ARGV[3]


case command
when '--list'
	Todo.list
when '--add'
	Todo.add(value1, value2)
when '--update'
	Todo.update(value1, value2, value3)
when '--remove'
	Todo.remove(value1)
end

# puts "\nDisplays task.all"
# a = Task.all
# a.each do |task|
# 	p task
# end