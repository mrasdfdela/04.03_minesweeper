require_relative "board"
require "byebug"

class Game
    attr_reader :board
    
    def initialize(boardSize)
        @board = Board.new(boardSize)
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
    
    def userInput
        print "Enter location (ex: 3,4) >> "
        location = gets.chomp.split(",")
    end
end

testGame = Game.new("small")
testGame.board.showBoard("currentGame")
testGame.selectDifficulty