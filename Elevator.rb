require 'thread'

class Elevator
  attr_accessor :name, :maxFloor, :destinations, :direction, :currentFloor, :status
  NOT_IDLE_MULTIPLIER = 2
  
  IDLE = "idle"
  MOVING = "moving"
  OPEN = "open"
  CLOSE = "close"
  SHUTDOWN = "shutdown"
  
  EACH_FLOOR_MOVING_TIME = 1 #second
  GROUND_FLOOR = 0
  
  COUNT_TO_OPEN = 5
  SEMAPHORE = Mutex.new
  
  def initialize(name, maxFloor, currentFloor)
    @name = name
    @maxFloor = maxFloor
    @currentFloor = currentFloor
    @status = IDLE
    @destinations = []
  end
  
  def add_destination(floor)
    SEMAPHORE.synchronize do
      @destinations << floor
      @status = MOVING if @status == IDLE
    end
  end
  
  def move(fromFloor, toFloor)
    SEMAPHORE.synchronize do
      @destinations << toFloor
    end
  end
  
  def run
    Thread.new do
      openCount = 0
      status = get_status
      while (status != SHUTDOWN) do        
        case status
        when MOVING
          updateCurrentFloorAndDirection
          process_for_current_floor 
        when IDLE
        when OPEN
          openCount += 1
          
          if (openCount == COUNT_TO_OPEN)
            status = get_status
            closeElevator
            openCount = 0
          end
        end
        
        sleep EACH_FLOOR_MOVING_TIME  #simulate moving duration
        status = get_status
      end
    end
  end
  
  def get_status
    status = nil
    SEMAPHORE.synchronize do
      status = @status
    end
    status
  end
  
  def updateCurrentFloorAndDirection
    SEMAPHORE.synchronize do
      @currentFloor += 1 if @direction == "up"
      @currentFloor -= 1 if @direction == "down"
      
      @direction = "down" if @currentFloor == @maxFloor
      @direction = "up" if @currentFloor == GROUND_FLOOR
      
      puts "#{@name} floor: #{@currentFloor} direction: #{@direction}"
    end
  end
  
  def process_for_current_floor
    SEMAPHORE.synchronize do
      nearest = get_nearest_destination
      if @currentFloor == nearest
        @destinations.delete(@currentFloor)
        @status = OPEN 
        puts "#{@name} floor: #{@currentFloor} OPENED DOOR"
      end
    end
  end
  
  def closeElevator
    SEMAPHORE.synchronize do
      puts "#{@name} floor: #{@currentFloor} CLOSED DOOR"
      @status = CLOSE
      correct_direction if @destinations.size == 1
      @status = MOVING if @destinations.size > 0
    end
  end
  
  def correct_direction
    destination = get_nearest_destination
    @direction = "up" if destination > @currentFloor
    @direction = "down" if destination < @currentFloor
  end
  
  def get_nearest_destination
    nearest = nil
    nearest = @destinations[0] if @destinations.size > 0
    @destinations.each do |floor|
      if (@direction == "up")
        nearest = floor if (floor < nearest && floor > @currentFloor) || (nearest < @currentFloor && floor > @currentFloor) || (floor == @currentFloor)
      end
      
      if (@direction == "down")
        nearest = floor if (floor > nearest && floor <= @currentFloor) || (nearest > @currentFloor && floor <= currentFloor) || (floor == @currentFloor)
      end
    end
    
    nearest
  end
  
  def effort_to(destinationFloor, direction)
    if (status == IDLE)
      effort = (@currentFloor - destinationFloor).abs
    else
      if (@direction == direction)
        effort = NOT_IDLE_MULTIPLIER * ((@currentFloor - destinationFloor).abs)
      else
        # opposite direction
        effort = NOT_IDLE_MULTIPLIER * (@currentFloor + destinationFloor) if direction == "up"
        effort = NOT_IDLE_MULTIPLIER * (2 * @maxFloor - @currentFloor - destinationFloor)  if direction == "down"
      end
    end
    effort
  end
end