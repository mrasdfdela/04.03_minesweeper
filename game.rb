require_relative "board"
require "byebug"

class Game
    attr_reader :board, :gameEnded
    
    def initialize
        @board = Board.new(selectDifficulty)
        @gameEnded = false
    end
    
    def selectDifficulty
        invalid = false
        size = ""
        
        until ["small", "medium", "large"].include?(size.downcase)
            print "   ^ Invalid selection!\n\n" if size.length > 0 || invalid == true
            invalid = true
            
            print "Select size:\nSmall\nMedium\nLarge\n>> "
            size = gets.chomp
        end
        
        size
    end
    
    def playGame
        while @gameEnded == false
            # get location --> validate syntax, check if it has a flag or has been revealed already
            self.board.showBoard("currentGame")
            selectLocation
            @gameEnded = true
        end
    end
    
    def selectLocation
        validLocation = false
        until validLocation == true
            print "Enter location (ex: 3,4) >> "
            location = gets.chomp.split(",").map { |num| num.to_i }
            validLocation = validLocation?(location)
        end
    end
    def validLocation?(arr)
        yLoc, xLoc = arr[0].to_i, arr[1].to_i
        if arr.length != 2 || 
           arr.all? { |num| num.is_a? Numeric } == false ||
           yLoc >= board.boardSize["height"] ||
           xLoc >= board.boardSize["width"] ||
           board.board[yLoc][xLoc].revealed == true
           
            puts "Invalid entry!"
            false
        else
            true
        end
    end
    
    def evaluateLocation
        
    end
end

testGame = Game.new
# testGame.board.showBoard("currentGame")
testGame.playGame