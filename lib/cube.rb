class Cube
  attr_accessor :state, :hist

  #New states are instantiated in a solved state with a clean history.
  def initialize
    @state = [[0,0,0,0,0,0,0,0,0],[1,1,1,1,1,1,1,1,1],[2,2,2,2,2,2,2,2,2],[3,3,3,3,3,3,3,3,3],[4,4,4,4,4,4,4,4,4],[5,5,5,5,5,5,5,5,5]]
    @hist = []
  end

  def transformer
    @transformer ||= CubeTransformer.new(self)
  end

  #Removes any 4 of the same move in a row in @hist. Any move repeated four times ends the state in the state it started in.
  def clean_hist
    i = 0
    until i == @hist.length
      if @hist[i] == @hist[i+1] && @hist[i] == @hist[i+2] && @hist[i] == @hist[i+3] 
        4.times {@hist.delete_at(i)}
        i = -1
      end
     i += 1
    end

    i = 0
    until i == @hist.length
      if @hist[i] == @hist[i+1] && @hist[i].length < 3
        @hist.delete_at(i)
        @hist[i] = "#{@hist[i]}2"
        i = -1
      end
     i += 1
    end

    @hist.join(', ')
  end 

  #Turns state over TWICE, swapping top and bottom faces. Like "f2" but rest of cube moves too.
  def invert
    self.turn_over.turn_over
    @hist << "invert" 
    self
  end

  #Shuffles cross cubies on top, doesn't affect lower layers but does shuffle top corners.
  def cross_shuffle
     self.f.u.r.ur.rr.fr
    self
  end

  #Swaps [0][5] and [0][3]. Doesn't affect lower layers but does affect top corners.
  def cross_swap
    self.rr.u.u.r.u.rr.u.r.u
    self
  end

  #Shuffles top corners without affecting lower layers or top cross.
  def top_corner_shuffle
    self.rr.u.l.ur.r.u.lr.ur
    self
  end

  #Re-orients cubies of [0][4], [0][6], and [0][8] without affecting anything else.
  def last_move
    self.rr.d.d.r.f.d.d.fr.ur.f.d.d.fr.rr.d.d.r.u
    self
  end

  #Solves for cross on first layer. Affects all other layers. 
  def cross_solve 
    downcross = []
    i = 1
    until @state[0][1] == @cube[0][0] && @cube[0][3] == @cube[0][0]  && @cube[0][5] == @cube[0][0] && @cube[0][7] == @cube[0][0]
         
      until downcross.include?(@state[0][0]) 
         downcross = []
         self.rr.d.r.l.dr.lr.turn
         downcross = [@state[5][1],@cube[5][3],@cube[5][5], @cube[5][7]]
         i += 1
         if i > 10
           self.turn until @state[0][1] != @cube[0][0] 
           self.l.b 
           i = 1
         end
      end

      until @state[5][3] == cube[0][0]
        i =0
        self.d

        if i > 59 
          self.print
          gets
          end
          i+=1
      end

      until @state[0][7] != @cube[0][0]
        self.u
      end
     self.f.f
     downcross = []
    end

    until @state[4][3] == @cube[4][0] && @cube[1][5] == @cube[1][0]
      until @state[1][5] == @cube[1][0]        
        self.u
      end
      self.turn if @state[4][3] != @cube[4][0]
      i += 1

      if i > 10   
        self.cross_swap
        i = 1
      end
    end


    if @state[2][7] != @cube[2][0]
      self.cross_swap
    end

    self
  end

  #Solves for corners on first layer without affecting first layer cross.
  def corners_solve
    corners = []

    i = 1

    until @state[0].uniq == [@cube[0][0]] && @cube[1][4] == @cube[1][0] && @cube[2][6] == @cube[2][0] && @cube[3][2] == @cube[3][0] && @cube[4][2] == @cube[4][0]

      corners = [@state[1][8],@cube[1][2],@cube[2][4],@cube[2][2],@cube[3][4],@cube[3][6],@cube[4][6],@cube[4][8]]
      until corners.include?(0)
        self.rr.d.r.turn
        corners = [@state[1][8],@cube[1][2],@cube[2][4],@cube[2][2],@cube[3][4],@cube[3][6],@cube[4][6],@cube[4][8]]
      end
      
      until @state[3][6] == @cube[0][0] || @cube[4][6] == @cube[0][0] 
        self.d
      end

      if @state[3][6] == @cube[0][0]
        self.d.turn until @state[5][4] == @cube[3][0]
        self.rr.dr.r
      end

      if @state[4][6] == @cube[0][0]
        self.d.turn until @state[5][4] == @cube[4][0]
        self.f.d.fr
      end
      i += 1
      self.turn

      if i > 50
        self.u until @state[0][6] != @cube[0][0]
        self.d until @state[5][4] == @cube[0][0]
        self.lr.d.l
        self.u until @state[1][5] == @cube[1][0]
        i = 1
      end
    end
    self
  end

  #Solves for middle layer when first layer is solved without affecting first layer.
  def second_layer_solve
    self.invert
    mids = []
    x = @state[0][0]

    until mids.include?(x) == false && @state[1][7] == @cube[1][0] && @cube[1][3] == @cube[1][0] && @cube[3][3] == @cube[3][0] && @cube[3][7] == @cube[3][0] && @cube[2][1] == @cube[2][0] && @cube[2][5] == @cube[2][0] && @cube[4][1] == @cube[4][0] && @cube[4][5] == @cube[4][0]

      until @state[4][5] == @cube[4][0] && @cube[3][7] == @cube[3][0]
      i = 0

        until @state[4][3] != @cube[0][0] && @cube[0][7] != @cube[0][0] 
          self.u
          i += 1

          if i > 50
            self.cross_swap
            self.u.r.ur.rr.ur.fr.u.f
            i = 1
          end
        end

        until @state[4][3] == @cube[4][0]
          self.ur.turn
        end

        if @state[0][7] != @cube[3][0]
          self.cross_swap
        end
        self.u.r.ur.rr.ur.fr.u.f
      end
      self.turn
      mids = [@state[1][3],@cube[1][7],@cube[2][1],@cube[2][5],@cube[3][3],@cube[3][7],@cube[4][1],@cube[4][5]]
    end

    self
  end

  #Solves for last layer cross when first two layers are completed
  def top_cross
     topcross = [@state[0][1],@cube[0][3],@cube[0][5],@cube[0][7]]
    i = 1
    bigi = 0
    until topcross.count(@state[0][0]) >= 2
      self.cross_shuffle
      bigi += 1
      i += 1

      if i > 15
        self.turn
        i = 1
      end

      if bigi > 100
        puts "derp"
        p topcross
      gets
      end
    topcross = [@state[0][1],@cube[0][3],@cube[0][5],@cube[0][7]]
    end

    if (topcross[0] == @state[0][0] && topcross[2] == @cube[0][0]) || (topcross[1] == @cube[0][0] && topcross[3] == @cube[0][0])
      self.turn until @state[0][7] == @cube[0][0] 
      self.cross_swap
    end
    
    self.turn until @state[0][1] == @cube[0][0] && @cube[0][3] == @cube[0][0]

    i = 1
    until topcross.uniq == [@state[0][0]]
      self.cross_shuffle

      if i > 20
        self.turn
      end
      topcross = [@state[0][1],@cube[0][3],@cube[0][5],@cube[0][7]]
    end
    i = 1
    until @state[1][5] == @cube[1][0] && @cube[4][3] == @cube[4][0]
      self.u
      i += 1
      if i >17 
        self.cross_swap.turn.cross_swap
        i = 1
      end
    end
    self.cross_swap if @state[3][1] != @cube[3][0]
    self
  end

  #Solves last layer corners when all other layers and cross have been completed.
  def top_corners
    stay_corner = [@state[0][2], @cube[1][4],@cube[2][8]]
    i = 1

    until stay_corner.sort == [@state[1][0],@cube[2][0],@cube[0][0]].sort
      self.turn
      stay_corner = [@state[0][2], @cube[1][4],@cube[2][8]]
      i += 1

      if i > 4
        self.top_corner_shuffle
        i = 0
        stay_corner = [@state[0][2], @cube[1][4],@cube[2][8]]
      end
    end
    
    until @state[0][2] == @cube[0][0]
      self.turn.turn.last_move.turn.turn
    end

    stay4 = [@state[0][4], @cube[2][6],@cube[3][2]]
    until stay4.sort == [@state[2][0],@cube[3][0],@cube[0][0]].sort
      
    self.top_corner_shuffle
      stay4 = [@state[0][4], @cube[2][6],@cube[3][2]]
    end

    self.turn.last_move.turn.turn.turn until @state[0][4] == @cube[0][0]

    if @state[0][4] == @cube[0][0] && @cube[0][6] != @cube[0][0]
      i = 1


      testarray = [] 
      until testarray.flatten.uniq.length == 6

        @state.each {|side| testarray << side.uniq}

        self.last_move
        i += 1
        if i > 100
          i = 1
        end
      end
    end

    if @state[0][6] != @cube[0][0]
      self.last_move
    end
  end

  #solve invokes all layer solving methods in sequence, solving from any legal state 
  def simple_solve
    testarray = [] 
    @state.each {|side| testarray << side.uniq}
    return self if testarray.flatten.length == 6

    self.cross_solve.corners_solve.second_layer_solve.top_cross.top_corners
    self.clean_hist
    self.invert
    self
  end

  self
end

