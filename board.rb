require_relative "tile"
require "byebug"

class Board 
    attr_reader :boardSize, :board
    
    def initialize(size, difficulty=nil)
        @boardSize = genBoardSize(size, difficulty)
        @board = createBoard(boardSize)
    end
    
    def genBoardSize(size, difficulty)
        case size.downcase
            when "small"
                var = {"width"=>9, "height"=>9, "mines"=>10}
            when "medium"
                var = {"width"=>16, "height"=>16, "mines"=>40}
            when "large"
                var = {"width"=>30, "height"=>16, "mines"=>99}
        end
    end
    
    def createBoard(sizeHash)
        w = sizeHash["width"]
        h = sizeHash["height"]
        m = sizeHash["mines"]
        
        mines = arr = (0...w*h).to_a.sample(m)
        board = Array.new(h){ Array.new(w) }
        
        board.each_with_index {|row, i|
            board.each_with_index {|el, j|
                
                if mines.include?(i*(row.length) + j)
                    board[i][j] = Tile.new(true)
                else
                    board[i][j] = Tile.new
                end
            }
        }
    end
     
    def showBoard(type)
        topRow = " "
        (0...boardSize["width"]).to_a.each { |el|
            topRow += " #{el}"
        }
        puts topRow
        
        boardRows = ""
        board.each_with_index{ |row, idx|
            boardRows += "#{idx}"
            row.each{ |el|
                case type  
                when "revealed"
                    boardRows += showBoardRevealed(el)
                when "currentGame"
                    boardRows += showBoardCurrentGame(el)
                end        
            }
            boardRows += "\n"
        }
        
        puts boardRows
    end
    def showBoardRevealed(tileElement)
        tileElement.mine == true ? " M" : "  "
    end
    def showBoardCurrentGame(tileElement)
        el = tileElement
        if el.flagged == true
            " F"
        elsif el.revealed == true
            "  "
        elsif el.mineExploded == true
            " X"
        else
            " *"
        end
    end
end

# board = Board.new("small")
# board.showBoard("revealed")
# board.showBoard("currentGame")