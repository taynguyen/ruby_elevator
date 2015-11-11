require 'thread'
load 'Building.rb'

Thread.abort_on_exception = true


building = Building.new(numberOfFloor=10, numberOfElevator=4)
building.activate_elevators

# call to get an elevator at floor 5
elevator1 = building.call_elevator_to_floor(5, "up")

#wait about 7 second to elevator1 come to floor 5
sleep(7)
#then use elevator 1 to move to floor 2
elevator1.add_destination(0)

# at this time, call to get an elevator at floor 1, elevator 2
elevator2 = building.call_elevator_to_floor(1, "up")
#wait about 2 second for elevator 2 to come,
sleep(2)
#use elevator2 to move to floor 4. At this time, 2 elevators work concurrenly
elevator2.add_destination(6)


while true
  # keep program alive to see elevator working
end