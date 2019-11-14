class Tile
    attr_reader :mine, :revealed
    
    def initialize(mine=false)
        @mine = false
        @revealed = false
        @flagged = false
        @wrongChoice = false
    end
    
    def mine
        mine = @mine
    end
end