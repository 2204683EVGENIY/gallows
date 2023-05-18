require_relative "lib/console_interface"
require_relative "lib/game"
require "colorize"

# 1. Say hello
puts "Hello!".colorize(:color => :yellow, :mode => :bold)

# 2. Download a random word from a file
word = File.readlines(__dir__ + "/data/words.txt", encoding: "UTF-8", chomp: true).sample
game = Game.new(word)
console_interface = ConsoleInterface.new(game)

# 3. Until the game is over
until game.over?
  #  3.1 Display the next state of the game
  console_interface.print_out
  #  3.2 Ask for the next letter
  letter = console_interface.get_input
  #  3.3 Update game status
  game.play!(letter)
end

# 4. Output the final state of the game
console_interface.print_out
