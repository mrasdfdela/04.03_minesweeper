class Tile
    attr_reader :mine
    attr_accessor :mineExploded, :flagged, :revealed, :edge , :adjMines
    
    def initialize(mine=false)
        @mine = mine
        @mineExploded = false
        @flagged = false
        @revealed = false
        @edge = false
        
        @adjMines = 0
    end
end