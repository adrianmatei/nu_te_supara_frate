require_relative 'pawn'

class Player
  attr_accessor :name, :winner, :position_offset, :current_roll, :pawns_array
  
  def initialize(name, offset)
    self.name = name
    self.position_offset = offset
    self.winner = false
    self.current_roll = 0
    self.pawns_array = Array.new
    4.times { pawns_array << Pawn.new }
  end

  def roll_dice
    self.current_roll = (1 + rand(6))
  end

  def select_pawn(dice_result)
    active_pawns = pawns_array.select { |pawn| pawn.active == true && pawn.finished == false }
    choose_pawn(dice_result,active_pawns)
  end

  def move_pawn(pawn, dice_result)
    pawn.move(dice_result, self.position_offset)
    check_pawn_finish(pawn, dice_result) if pawn.step_counter > $STEPS
    
    if pawn.step_counter > 0 # don't show after pawn has finished
      puts "New pawn board position: #{pawn.board_position.to_s}; total steps done: #{pawn.step_counter.to_s}"
      puts "Pawn has finished" if pawn.finished == true
    end
    check_winner
  end

  private

  def choose_pawn(dice_result,active_pawns)
    selected_pawn = nil
    if dice_result == 6
      if pawns_array.any? { |pawn| pawn.active == false && pawn.finished == false } # if there are disabled pawns
        puts 'One more of your pawns has been added to the game!'
        puts 'You can roll again!'
        selected_pawn = pawns_array.find {|pawn| pawn.active == false && pawn.finished == false }
        selected_pawn.activate
        return selected_pawn
      else
        if active_pawns.size > 1
          selected_pawn = active_pawns[choose_between_pawns(active_pawns)] # choose pawn if there are more on the table
        else
          selected_pawn = active_pawns[0] # if there is only one pawn on the table, select it directly
        end
      end
    else
      if active_pawns.size > 1
        chosen = choose_between_pawns(active_pawns)
        chosen = active_pawns.size - 1 if chosen > active_pawns.size
        selected_pawn = active_pawns[chosen]
      else
        selected_pawn = active_pawns[0] # if there is only one pawn on the table, select it
      end
    end
    selected_pawn
  end

  def choose_between_pawns(pawns)
    puts "Player #{self.name.to_s}: you have #{pawns.size.to_s} pawns available. Their positions on the table are:"

    pawns.each_with_index do |pawn, index|
      puts "Pawn #{(index + 1).to_s}: board position: #{pawn.board_position.to_s}, #{pawn.step_counter.to_s} steps done"
    end
    puts 'Please select a pawn by typeing the number'

    begin
      selected_index = gets.chomp
      selected_index = Integer(selected_index) - 1 # make it start from 0 to match array
    rescue
      print "Ooops... Please select a valid number: "
      retry
    end
  end

  # check if player has won and exit script
  def check_winner
    if pawns_array.all? { |pawn| pawn.finished == true }
      puts "Player #{self.name.to_s} has won!!! Congrats!!!"
      exit
    end
  end

  # check if finish position is available
  def check_pawn_finish(pawn, dice_result)
    finish_array = []
    self.pawns_array.each { |pawn| finish_array << pawn.finish_position }
    finish_pos = pawn.step_counter - $STEPS # see what the finish position would be

    if finish_array.include? finish_pos
      pawn.reset_position(dice_result)
    else
      pawn.finish(finish_pos)
    end
  end
end
