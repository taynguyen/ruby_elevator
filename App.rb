load 'Building.rb'

buidling = Building.new(numberOfFloor=10, numberOfElevator=3)

elevator = building.call_elevator_to_floor(0)
elevator.move(fromFloor = 0, toFloor = 5)

# Sometime passed
elevator = building.call_elevator_to_floor(0)
elevato.move(fromFloor=0, toFloor = 9)

# Sometime passed
elevator = building.call_elevator_to_floor(7)
elevato.move(fromFloor=7, toFloor = 3)
