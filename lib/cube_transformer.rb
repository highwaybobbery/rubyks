class CubeTransformer
  attr_accessor :cube

  def initialize(cube)
    @cube = cube
  end

  #Scrambles cube.state with 100 random moves and clears history
  def scramble
    100.times do 
      turn = rand(5)
      l if turn == 0
      r if turn == 1
      u if turn == 2
      d if turn == 3
      f if turn == 4
      b if turn == 5
    end

    cube.clear_history
  end

  #Turns left face clockwise
  def l
    temp_state  = cube.state.clone
    cells [1,2,8]

    shift_faces(
      target: temp_state,
      source: cube.state,
      target_faces: [0,2,5,4],
      source_faces: [2,5,4,0],
      cells: cells,
    )

    remap_face(
      target: temp_state,
      source: cube.state,
      face: 1,
      source_order: [7,8,1,2,3,4,5,6]
    )

    cube.state = temp_state
    @hist << 'l'
    self
  end

  def shift_faces(opts)
    target = opts[:target]
    source = opts[:source]

    4.times do |face_index|
      target_face = target[opts[:target_faces][face_index]]
      source_face = source[opts[:source_faces][face_index]]

      opts[:cells].each do |cell|
        target_face[cell] = source_face[cell]
      end
    end
  end

  #Turns left face counter-clockwise
  def lr
    3.times do 
      self.l
      @hist.pop
    end
    @hist << 'lr'
    self
  end

  #Turns left face twice
  def l2
    self.l.l
    @hist << 'l2'
    self
  end

  #Turns right face clockwise
  def r
    cube_statetemp = Marshal.load(Marshal.dump(@cube))

    cube_statetemp[0][4] = @cube[4][4]
    cube_statetemp[0][5] = @cube[4][5]
    cube_statetemp[0][6] = @cube[4][6]

    cube_statetemp[4][4] = @cube[5][4]
    cube_statetemp[4][5] = @cube[5][5]
    cube_statetemp[4][6] = @cube[5][6]

    cube_statetemp[5][4] = @cube[2][4]
    cube_statetemp[5][5] = @cube[2][5]
    cube_statetemp[5][6] = @cube[2][6]

    cube_statetemp[2][4] = @cube[0][4]
    cube_statetemp[2][5] = @cube[0][5]
    cube_statetemp[2][6] = @cube[0][6]

    cube_statetemp[3][1] = @cube[3][7]
    cube_statetemp[3][2] = @cube[3][8]
    cube_statetemp[3][3] = @cube[3][1]
    cube_statetemp[3][4] = @cube[3][2]
    cube_statetemp[3][5] = @cube[3][3]
    cube_statetemp[3][6] = @cube[3][4]
    cube_statetemp[3][7] = @cube[3][5]
    cube_statetemp[3][8] = @cube[3][6]

    @hist << 'r'
    @cube_state = Marshal.load(Marshal.dump(cubetemp))
    self
  end

  #Turns right face counter-clockwise
  def rr
    3.times do 
      self.r
      @hist.pop
    end
    @hist << "rr"
    self
  end

  #Turns right face twice
  def r2
    self.r.r
    @hist << 'r2'
    self
  end

  #Turns front face clockwise
  def f
    cube_statetemp = Marshal.load(Marshal.dump(@cube))

    cube_statetemp[0][6] = @cube[1][6]
    cube_statetemp[0][7] = @cube[1][7]
    cube_statetemp[0][8] = @cube[1][8]

    cube_statetemp[1][6] = @cube[5][2]
    cube_statetemp[1][7] = @cube[5][3]
    cube_statetemp[1][8] = @cube[5][4]

    cube_statetemp[5][2] = @cube[3][6]
    cube_statetemp[5][3] = @cube[3][7]
    cube_statetemp[5][4] = @cube[3][8]

    cube_statetemp[3][8] = @cube[0][8]
    cube_statetemp[3][7] = @cube[0][7]
    cube_statetemp[3][6] = @cube[0][6]

    cube_statetemp[4][1] = @cube[4][7]
    cube_statetemp[4][2] = @cube[4][8]
    cube_statetemp[4][3] = @cube[4][1]
    cube_statetemp[4][4] = @cube[4][2]
    cube_statetemp[4][5] = @cube[4][3]
    cube_statetemp[4][6] = @cube[4][4]
    cube_statetemp[4][7] = @cube[4][5]
    cube_statetemp[4][8] = @cube[4][6]

    @hist << 'f'
    @cube_state = Marshal.load(Marshal.dump(cubetemp))
    self
  end
  #Turns front face counter-clockwise
  def fr
    3.times do 
      self.f
      @hist.pop
    end
    @hist << "fr"
    self
  end
  #Turns front face twice
  def f2
    self.f.f
    @hist << 'f2'
    self
  end

  #Turns back face clockwise
  def b
    cube_statetemp = Marshal.load(Marshal.dump(@cube))

    cube_statetemp[0][2] = @cube[3][2]
    cube_statetemp[0][3] = @cube[3][3]
    cube_statetemp[0][4] = @cube[3][4]

    cube_statetemp[1][2] = @cube[0][2]
    cube_statetemp[1][3] = @cube[0][3]
    cube_statetemp[1][4] = @cube[0][4]

    cube_statetemp[3][2] = @cube[5][6]
    cube_statetemp[3][3] = @cube[5][7]
    cube_statetemp[3][4] = @cube[5][8]

    cube_statetemp[5][6] = @cube[1][2]
    cube_statetemp[5][7] = @cube[1][3]
    cube_statetemp[5][8] = @cube[1][4]



    cube_statetemp[2][1] = @cube[2][7]
    cube_statetemp[2][2] = @cube[2][8]
    cube_statetemp[2][3] = @cube[2][1]
    cube_statetemp[2][4] = @cube[2][2]
    cube_statetemp[2][5] = @cube[2][3]
    cube_statetemp[2][6] = @cube[2][4]
    cube_statetemp[2][7] = @cube[2][5]
    cube_statetemp[2][8] = @cube[2][6]

    @hist << 'b'
    @cube_state = Marshal.load(Marshal.dump(cubetemp))
    self
  end
  #Turns back face counter-clockwise
  def br
    3.times do 
      self.b
      @hist.pop
    end
    @hist << "br"
    self
  end
  #Turns back face twice
  def b2
    self.b.b
    @hist << 'b2'
    self
  end

  #Turns top face clockwise
  def u
    cube_statetemp = Marshal.load(Marshal.dump(@cube))

    cube_statetemp[1][4] = @cube[4][2]
    cube_statetemp[1][5] = @cube[4][3]
    cube_statetemp[1][6] = @cube[4][4]

    cube_statetemp[4][2] = @cube[3][8]
    cube_statetemp[4][3] = @cube[3][1]
    cube_statetemp[4][4] = @cube[3][2]

    cube_statetemp[3][8] = @cube[2][6]
    cube_statetemp[3][1] = @cube[2][7]
    cube_statetemp[3][2] = @cube[2][8]

    cube_statetemp[2][6] = @cube[1][4]
    cube_statetemp[2][7] = @cube[1][5]
    cube_statetemp[2][8] = @cube[1][6]

    cube_statetemp[0][1] = @cube[0][7]
    cube_statetemp[0][2] = @cube[0][8]
    cube_statetemp[0][3] = @cube[0][1]
    cube_statetemp[0][4] = @cube[0][2]
    cube_statetemp[0][5] = @cube[0][3]
    cube_statetemp[0][6] = @cube[0][4]
    cube_statetemp[0][7] = @cube[0][5]
    cube_statetemp[0][8] = @cube[0][6]

    @hist << 'u'
    @cube_state = Marshal.load(Marshal.dump(cubetemp))
    self  
  end
  #turns top face counter-clockwise
  def ur
    3.times do 
      self.u
      @hist.pop
    end
    @hist << "ur"
    self
  end
  #turns top face twice
  def u2
    self.u.u
    @hist << 'u2'
    self
  end

  #Turns bottom face clockwise
  def d
    cube_statetemp = Marshal.load(Marshal.dump(@cube))

    cube_statetemp[1][8] = @cube[2][2]
    cube_statetemp[1][1] = @cube[2][3]
    cube_statetemp[1][2] = @cube[2][4]

    cube_statetemp[2][2] = @cube[3][4]
    cube_statetemp[2][3] = @cube[3][5]
    cube_statetemp[2][4] = @cube[3][6]

    cube_statetemp[3][4] = @cube[4][6]
    cube_statetemp[3][5] = @cube[4][7]
    cube_statetemp[3][6] = @cube[4][8]

    cube_statetemp[4][6] = @cube[1][8]
    cube_statetemp[4][7] = @cube[1][1]
    cube_statetemp[4][8] = @cube[1][2]

    cube_statetemp[5][1] = @cube[5][7]
    cube_statetemp[5][2] = @cube[5][8]
    cube_statetemp[5][3] = @cube[5][1]
    cube_statetemp[5][4] = @cube[5][2]
    cube_statetemp[5][5] = @cube[5][3]
    cube_statetemp[5][6] = @cube[5][4]
    cube_statetemp[5][7] = @cube[5][5]
    cube_statetemp[5][8] = @cube[5][6]

    @hist << 'd'
    @cube_state = Marshal.load(Marshal.dump(cubetemp))
    self
  end
  #Turns bottom face counter-clockwise
  def dr
    3.times do 
      self.d
      @hist.pop
    end
    @hist << "dr"
    self
  end
  #Turns bottom face twice
  def d2
    self.d.d
    @hist << 'l2'
    self
  end

  # Turns cube_state clockwise ONCE, like "u" but rest of cube moves too.
  def turn 
    cube_statetemp = [[],[],[],[],[],[]]

    cube_statetemp[0][0] = @cube[0][0]
    cube_statetemp[0][1] = @cube[0][7]
    cube_statetemp[0][2] = @cube[0][8]
    cube_statetemp[0][3] = @cube[0][1]
    cube_statetemp[0][4] = @cube[0][2]
    cube_statetemp[0][5] = @cube[0][3]
    cube_statetemp[0][6] = @cube[0][4]
    cube_statetemp[0][7] = @cube[0][5]
    cube_statetemp[0][8] = @cube[0][6]

    cube_statetemp[1][0] = @cube[4][0]
    cube_statetemp[1][1] = @cube[4][7]
    cube_statetemp[1][2] = @cube[4][8]
    cube_statetemp[1][3] = @cube[4][1]
    cube_statetemp[1][4] = @cube[4][2]
    cube_statetemp[1][5] = @cube[4][3]
    cube_statetemp[1][6] = @cube[4][4]
    cube_statetemp[1][7] = @cube[4][5]
    cube_statetemp[1][8] = @cube[4][6]

    cube_statetemp[2][0] = @cube[1][0]
    cube_statetemp[2][1] = @cube[1][7]
    cube_statetemp[2][2] = @cube[1][8]
    cube_statetemp[2][3] = @cube[1][1]
    cube_statetemp[2][4] = @cube[1][2]
    cube_statetemp[2][5] = @cube[1][3]
    cube_statetemp[2][6] = @cube[1][4]
    cube_statetemp[2][7] = @cube[1][5]
    cube_statetemp[2][8] = @cube[1][6]

    cube_statetemp[3][0] = @cube[2][0]
    cube_statetemp[3][1] = @cube[2][7]
    cube_statetemp[3][2] = @cube[2][8]
    cube_statetemp[3][3] = @cube[2][1]
    cube_statetemp[3][4] = @cube[2][2]
    cube_statetemp[3][5] = @cube[2][3]
    cube_statetemp[3][6] = @cube[2][4]
    cube_statetemp[3][7] = @cube[2][5]
    cube_statetemp[3][8] = @cube[2][6]

    cube_statetemp[4][0] = @cube[3][0]
    cube_statetemp[4][1] = @cube[3][7]
    cube_statetemp[4][2] = @cube[3][8]
    cube_statetemp[4][3] = @cube[3][1]
    cube_statetemp[4][4] = @cube[3][2]
    cube_statetemp[4][5] = @cube[3][3]
    cube_statetemp[4][6] = @cube[3][4]
    cube_statetemp[4][7] = @cube[3][5]
    cube_statetemp[4][8] = @cube[3][6]

    cube_statetemp[5][0] = @cube[5][0]
    cube_statetemp[5][1] = @cube[5][3]
    cube_statetemp[5][2] = @cube[5][4]
    cube_statetemp[5][3] = @cube[5][5]
    cube_statetemp[5][4] = @cube[5][6]
    cube_statetemp[5][5] = @cube[5][7]
    cube_statetemp[5][6] = @cube[5][8]
    cube_statetemp[5][7] = @cube[5][1]
    cube_statetemp[5][8] = @cube[5][2]

    @hist << 'turn'
    @cube_state = cubetemp
    self
  end

  #Turns cube_state over ONCE, like "fr" but rest of cube moves too.
  def turn_over 
    cube_statetemp = [[],[],[],[],[],[]]

    cube_statetemp[0][0] = @cube[3][0]
    cube_statetemp[0][1] = @cube[3][1]
    cube_statetemp[0][2] = @cube[3][2]
    cube_statetemp[0][3] = @cube[3][3]
    cube_statetemp[0][4] = @cube[3][4]
    cube_statetemp[0][5] = @cube[3][5]
    cube_statetemp[0][6] = @cube[3][6]
    cube_statetemp[0][7] = @cube[3][7]
    cube_statetemp[0][8] = @cube[3][8]

    cube_statetemp[1][0] = @cube[0][0]
    cube_statetemp[1][1] = @cube[0][1]
    cube_statetemp[1][2] = @cube[0][2]
    cube_statetemp[1][3] = @cube[0][3]
    cube_statetemp[1][4] = @cube[0][4]
    cube_statetemp[1][5] = @cube[0][5]
    cube_statetemp[1][6] = @cube[0][6]
    cube_statetemp[1][7] = @cube[0][7]
    cube_statetemp[1][8] = @cube[0][8]

    cube_statetemp[2][0] = @cube[2][0]
    cube_statetemp[2][1] = @cube[2][7]
    cube_statetemp[2][2] = @cube[2][8]
    cube_statetemp[2][3] = @cube[2][1]
    cube_statetemp[2][4] = @cube[2][2]
    cube_statetemp[2][5] = @cube[2][3]
    cube_statetemp[2][6] = @cube[2][4]
    cube_statetemp[2][7] = @cube[2][5]
    cube_statetemp[2][8] = @cube[2][6]

    cube_statetemp[3][0] = @cube[5][0]
    cube_statetemp[3][1] = @cube[5][5]
    cube_statetemp[3][2] = @cube[5][6]
    cube_statetemp[3][3] = @cube[5][7]
    cube_statetemp[3][4] = @cube[5][8]
    cube_statetemp[3][5] = @cube[5][1]
    cube_statetemp[3][6] = @cube[5][2]
    cube_statetemp[3][7] = @cube[5][3]
    cube_statetemp[3][8] = @cube[5][4]

    cube_statetemp[4][0] = @cube[4][0]
    cube_statetemp[4][1] = @cube[4][3]
    cube_statetemp[4][2] = @cube[4][4]
    cube_statetemp[4][3] = @cube[4][5]
    cube_statetemp[4][4] = @cube[4][6]
    cube_statetemp[4][5] = @cube[4][7]
    cube_statetemp[4][6] = @cube[4][8]
    cube_statetemp[4][7] = @cube[4][1]
    cube_statetemp[4][8] = @cube[4][2]

    cube_statetemp[5][0] = @cube[1][0]
    cube_statetemp[5][1] = @cube[1][5]
    cube_statetemp[5][2] = @cube[1][6]
    cube_statetemp[5][3] = @cube[1][7]
    cube_statetemp[5][4] = @cube[1][8]
    cube_statetemp[5][5] = @cube[1][1]
    cube_statetemp[5][6] = @cube[1][2]
    cube_statetemp[5][7] = @cube[1][3]
    cube_statetemp[5][8] = @cube[1][4]

    @cube_state = cubetemp
    self
  end

end
