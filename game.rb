require_relative 'player'

class Game
  attr_accessor :players_arr

  def initialize
    player_nr = 2
    self.players_arr = Array.new
    player_nr.times { |i| players_arr << Player.new(i + 1, i * 10) } # sets name and table position offset

    select_player
  end

  def select_player
    while players_arr.all? { |player| player.winner == false }
      players_arr.each do |player|
        play_round player
      end
    end
  end

  def play_round(player, selected_pawn = nil)
    dice_result = roll_dice(player)
    opponent_pawns = get_opponent_pawns(player) # gets the positions of all active pawns from other users

    # return if the player has no active pawns
    if dice_result != 6
      unless player.pawns_array.any? { |pawn| pawn.active == true && pawn.finished == false }
        puts 'Bad luck! You need to get a 6. Try again!'
        return
      end
    end

    selected_pawn = player.select_pawn(dice_result) if selected_pawn.nil?

    # when you hit 6, proceed with the same pawn
    if dice_result == 6
      play_round(player, selected_pawn)
      return
    end

    player.move_pawn(selected_pawn, dice_result)
    disable_pawn(opponent_pawns, selected_pawn.board_position)
  end

  private

  def roll_dice(player)
    puts '', '', 'Player ' + player.name.to_s + ': Press enter to roll your dice'
    gets

    dice_result = player.roll_dice
    puts 'Player ' + player.name.to_s + ': you have rolled ' + dice_result.to_s
    dice_result
  end

  def get_opponent_pawns(player)
    opponent_pawns = []
    players_arr.reject{|p| p == player}.each do |player|
      player.pawns_array.each { |pawn| opponent_pawns << pawn }
    end
    opponent_pawns
  end

  # check if curent move steps on pawn. If so, disable and reset
  def disable_pawn(opponent_pawns, pawn_pos)
    opponent_pawns.each do |opponent|
      opponent.reset if opponent.board_position == pawn_pos
    end
  end
end
