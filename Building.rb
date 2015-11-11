load 'Elevator.rb'
class Building
  def initialize(numberOfFloor, numberOfElevator)
    @numberOfFloor = numberOfFloor
    @numberOfElevator = numberOfElevator

    @elevators = initializeElevators(numberOfElevator)
  end

  def initializeElevators(numberOfElevator)
    #create elevator, start floor of each elevator is at floor 0
    elevatorArr = []
    for index in 1..numberOfElevator
      elevator = Elevator.new("Elevator #{index}" ,maxFloor = @numberOfFloor, currentFloor = 0)
      elevatorArr << elevator
    end

    elevatorArr
  end

  def activate_elevators
    # make each elevator function as thread
    @elevators.each do |elevator|
      elevator.run
    end
  end

  def call_elevator_to_floor(floorNumber, direction)
    elevator = get_suitable_elevator(floorNumber, direction)
    elevator.add_destination(floorNumber)
    return elevator
  end

  def get_suitable_elevator(destinationFloor, direction)
    suitable = @elevators[0]
    @elevators.each do |elevator|
      suitable = elevator if (elevator.effort_to(destinationFloor, direction) < suitable.effort_to(destinationFloor, direction))
    end

    suitable
  end
end