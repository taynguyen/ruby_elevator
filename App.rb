load 'Building.rb'

buidling = Building.new(numberOfFloor=10, numberOfElevator=3)

buidling.useElevator(numberOfPassenger=1, startFloor=0, destinationFloor=5)
buidling.useElevator(numberOfPassenger=1, startFloor=0, destinationFloor=5)
buidling.useElevator(numberOfPassenger=2, startFloor=3, destinationFloor=4)
