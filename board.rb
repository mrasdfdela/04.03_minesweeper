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
            else      
        end
        
        var
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
    
    def revealBoard
        topRow = "  "
        (0..boardSize["width"]).to_a.each { |el|
            topRow += " #{el}"
        }
        print topRow
        
        board.each_with_index{ |row, idx|
            boardRows = "#{idx} "
            row.each{ |el|
                puts el
                # if el.mine == true
                #     boardRows += " M"
                # else
                #     boardRows += "  "
                # end
            }
        }
        
        return ""
    end
end

    

debugger
board = Board.new("small")
# puts board.revealBoard