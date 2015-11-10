class Building
  def initialize(numberOfFloor, numberOfElevator)
    @numberOfFloor = numberOfFloor
    @numberOfElevator = numberOfElevator
  end
  
  def useElevator(numberOfPassenger, startFloor, destinationFloor)
    puts "#{numberOfPassenger} passengers travel from #{startFloor} floor to #{destinationFloor} floor"
  end
end