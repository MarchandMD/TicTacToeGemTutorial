require 'spec_helper'

module TicTacToe
  
  RSpec.describe Game do
    
    let(:bob) { Player.new({color: "X", name: "bob"} ) }
    let(:frank) { Player.new({color: "O", name: "frank"} ) }
    
    context "#initialize" do
      it "randomly selects a current player" do
        allow_any_instance_of(Array).to receive(:shuffle) { [frank, bob] }
        game = Game.new([frank, bob])
        expect(game.current_player).to eq frank
      end

      it "randomly selects an other player" do
        allow_any_instance_of(Array).to receive(:shuffle) { [frank, bob] }
        game = Game.new([frank, bob])
        expect(game.other_player).to eq bob
      end
    end

    context "#switch_player" do
      it "will set @current_player to @other_player" do
        game = Game.new([bob, frank])
        other_player = game.other_player
        game.switch_players
        expect(game.current_player).to eq(other_player)
      end

      it "will set @other_player to @current_player" do 
        game = Game.new([bob, frank])
        current_player = game.current_player
        game.switch_players
        expect(game.other_player).to eq(current_player)
      end
    end

    context "#solicit_move" do
      it "sends a message to the user" do
        game = Game.new([frank, bob])
        allow(game).to receive(:current_player) { frank }
        expect(game.solicit_move).to eq("frank: select a number from 1 - 9 to make a move")
      end
    end

    context "#get_move" do
      it "converts human move of 1 to [0,0]" do
        game = Game.new([bob, frank])
        expect(game.get_move("1")).to eq([0,0])
      end
      it "converts human move of 7 to [0,2]" do
        game = Game.new([bob, frank])
        expect(game.get_move("7")).to eq([0,2])
      end
    end

    context "#game_over_message" do
      it "returns the name of the winner" do
        game = Game.new([frank, bob])
        allow(game).to receive(:current_player) { frank }
        allow(game.board).to receive(:game_over) { :winner }
        expect(game.game_over_message).to eq("frank won!") 
      end

      it "returns 'the game ended in a draw' if no winner" do
        game = Game.new([frank, bob])
        allow(game.board).to receive(:game_over) { :draw }
        expect(game.game_over_message).to eq("the game ended in a draw") 
      end
    end



  end
end
