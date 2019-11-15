class Tile
    attr_reader :mine, :revealed, :flagged, :wrongChoice
    
    def initialize(mine=false)
        @mine = mine
        @revealed = false
        @flagged = false
        @wrongChoice = false
    end
    
    def mine
        mine = @mine
    end
end