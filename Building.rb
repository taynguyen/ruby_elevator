class Building
  def initialize(numberOfFloor, numberOfElevator)
    @numberOfFloor = numberOfFloor
    @numberOfElevator = numberOfElevator
    
    initializeElevators(numberOfElevator)
  end
  
  def initializeElevators(numberOfElevator)
    # initialize instances of elevators
  end
  
  def useElevator(numberOfPassenger, startFloor, destinationFloor)
    puts "#{numberOfPassenger} passengers travel from #{startFloor} floor to #{destinationFloor} floor"
    
    elevator = getSuitableElevator()
    nearestElevator.carry(numberOfPassenger, startFloor, destinationFloor)
  end
  
  def call_elevator_to_floor(floorNumber)
    elevator = getNearestElevator()
    elevator.add_destination(floorNumber)
    return elevator
  end
end