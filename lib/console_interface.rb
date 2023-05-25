class ConsoleInterface
  FIGURES =
    Dir[("#{__dir__}/../data/figures/*.txt")]
      .sort
      .map { |file_name| File.read(file_name) }

  def initialize(game)
    @game = game
  end

  def errors_to_show
    @game.errors.join(", ")
  end

  def get_input
    print "Enter next letter: ".colorize(color: :yellow, mode: :bold)
    letter = gets[0].upcase
  end

  def print_out
    puts <<~GAME_INFO
      #{"Word".colorize(color: :yellow, mode: :bold)}: #{word_to_show.colorize(color: :blue, mode: :bold)}
      #{figure.colorize(color: :green, mode: :bold)}
      #{"Errors".colorize(color: :yellow, mode: :bold)} (#{@game.errors_made}): #{errors_to_show.colorize(color: :red, mode: :bold)}
      #{"Errors left".colorize(color: :yellow, mode: :bold)}: #{@game.errors_allowed}
    GAME_INFO

    if @game.won?
      puts "Congratulations, you win!".colorize(color: :green, mode: :bold)
    elsif @game.lost?
      puts "You loose, guessed word is: #{@game.word}".colorize(color: :red, mode: :bold)
    end
  end

  def figure
    FIGURES[@game.errors_made]
  end

  def word_to_show
    @game.letters_to_guess.map { |letter| letter || "__" }.join(" ")
  end
end
