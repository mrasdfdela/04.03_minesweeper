require_relative "tile"
require "byebug"

class Board 
    attr_reader :boardSize, :board
    
    def initialize(size, difficulty=nil)
        @boardSize = genBoardSize(size, difficulty)
        @board = createBoard(boardSize)
        adjacentMines
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
    
    def adjacentMines
        board.each_with_index { |row, i|
            board.each_with_index { |el, j|
                (i-1 .. i+1).each { |y|
                    (j-1 .. j+1).each { |x|
                        if validPosition?(x,y) && [i,j] != [y,x]
                            board[i][j].adjMines += 1 if board[y][x].mine == true
                        end
                        
                    }
                }
            }
        }
        
        # showBoard("adjMines")
    end
    
    def validPosition?(x,y)
        x.between?(0,self.boardSize["width"] -1 ) && 
        y.between?(0,self.boardSize["height"]-1 )
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
                # when "adjMines"
                #     boardRows += showBoardAdjMines(el)
                end        
            }
            boardRows += "\n"
        }
        
        puts boardRows
    end
    def showBoardRevealed(tileElement)
        el = tileElement
        if el.mineExploded == true
            " X"
        elsif el.mine == true 
            " M"
        elsif el.flagged == true
            " F"
        else
            "  "
        end
    end
    def showBoardCurrentGame(tileElement)
        el = tileElement
        # puts tileElement #only displays tile obj id
        if el.flagged == true
            " F"
        elsif el.revealed == true
            "  "
        elsif el.mineExploded == true
            " X"
        elsif el.edge == true
            " #{el.adjMines}"
        else
            " *"
        end
    end
    def showBoardAdjMines(titleElement)
        el = titleElement
        " #{titleElement.adjMines.to_s}"
    end

end