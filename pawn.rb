class Pawn
  $STEPS = 40 # the number of steps a pawn can make
  attr_accessor :step_counter, :board_position, :active, :finished, :finish_position

  def initialize
    self.step_counter = 1
    self.active = false
    self.finished = false
    self.finish_position = 0
    self.board_position = 0
  end

  def move(dice_result, offset)
    self.step_counter += dice_result
    position = self.step_counter + offset

    # set pawn position relative to the board(it can't be higher than 40)
    position > $STEPS ? self.board_position = position - $STEPS : self.board_position = position
  end

  def activate
    self.active = true
  end

  def reset
    self.step_counter = 1
    self.board_position = 0
    self.active = false
  end

  def reset_position(dice_result)
    self.step_counter -= dice_result
    self.board_position -= dice_result
    puts 'This finish position is already taken. Try again!'
  end

  def finish(position)
    puts 'Great! This pawn has finished the game!'
    self.finish_position = position
    self.step_counter = 0
    self.finished = true
    self.active = false
  end
end
