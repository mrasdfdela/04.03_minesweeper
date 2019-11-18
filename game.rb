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
            self.board.showBoard("revealed")
            self.board.showBoard("currentGame")
            userMove
            
            # self.board.showBoard("currentGame")
            # @gameEnded = true
        end
    end
    
    def userMove
        userBoard = self.board.board
        entrySelection = revealOrFlag
        entryLocation = selectLocation
            x = entryLocation[0]
            y = entryLocation[1]
        
        if entrySelection == "flag"
            userBoard[y][x].flagged = !userBoard[y][x].flagged
        else entrySelection == "reveal"
            evaluateMove(userBoard, x,y)
        end
    end
    
    def selectLocation
        validLocation = false
        location = []
        until validLocation == true
            print "Enter location (ex: 3,4) >> "
            location = gets.chomp.split(",").map { |num| num.to_i }
            validLocation = validLocation?(location)
        end
        location
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
    def revealOrFlag
        selection, validSelection = "", false
        
        until validSelection == true
            print "Select 'reveal' or 'flag'>> "
            selection = gets.chomp.downcase
            validSelection = true if selection == "reveal" || selection == "flag"
        end
        
        selection
    end
    
    
    def evaluateMove(userBoard, xCoor,yCoor)
        userBoard[yCoor][xCoor].revealed = true
        if userBoard[yCoor][xCoor].mine == true
            userBoard[yCoor][xCoor].mineExploded = true
            self.board.showBoard("revealed")
            @gameEnded = true
        else
            scanBoard(userBoard)
        end
    end
    def scanBoard(userBoard)
        
    end
    
end

testGame = Game.new
testGame.playGame