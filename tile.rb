class Tile
    attr_reader :mine
    attr_accessor :revealed, :flagged, :mineExploded
    
    def initialize(mine=false)
        @mine = mine
        @revealed = false
        @flagged = false
        @mineExploded = false
    end
    
    # def mine
    #     mine = @mine
    # end
end