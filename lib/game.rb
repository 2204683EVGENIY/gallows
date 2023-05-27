class Game
  TOTAL_ERRORS_ALLOWED = 7

  def self.normalize( letter )
    case letter
    when "Ё"
      "Е"
    when "Й"
      "И"
    else
      letter
    end
  end

  def initialize( word )
    @letters = word.chars
    @user_guesses = []
  end

  def errors
    @user_guesses - normalized_letters
  end

  def errors_made
    errors.length
  end

  def errors_allowed
    TOTAL_ERRORS_ALLOWED - errors_made
  end

  def letters_to_guess
    @letters.map { |letter| letter if @user_guesses.include?(self.class.normalize(letter)) }
  end

  def lost?
    errors_allowed == 0
  end

  def normalized_letters
    @letters.map { |letter| self.class.normalize(letter) }
  end

  def over?
    won? || lost?
  end

  def play!(letter)
    normalized_letter = self.class.normalize(letter)
    @user_guesses << normalized_letter if !over? && !@user_guesses.include?(normalized_letter)
  end

  def won?
    (normalized_letters - @user_guesses).empty?
  end

  def word
    @letters.join
  end
end
