class Game
  TOTAL_ERRORS_ALLOWED = 7
  def initialize(word)
    @letters = word.chars
    @user_guesses = []
  end

  def errors
    @user_guesses - normalized_letters
  end

  def errors_made
    return errors.length
  end

  def errors_allowed
    TOTAL_ERRORS_ALLOWED - errors_made
  end

  def letters_to_guess
    result =
    @letters.map do |letter|
      if @user_guesses.include?(self.class.normalize(letter))
        letter
      else
        nil
      end
    end
    return result
  end

  def lost?
    return errors_allowed == 0
  end

  def self.normalize(letter)
    case letter
    when "Ё"
      "Е"
    when "Й"
      "И"
    else
      letter
    end
  end

  def normalized_letters
    @letters.map { |letter| self.class.normalize(letter) }
  end

  def over?
    return won? || lost?
  end

  def play!(letter)
    normalized_letter = self.class.normalize(letter)
    if !over? && !@user_guesses.include?(normalized_letter)
      @user_guesses << normalized_letter
    end
  end

  def won?
    return (normalized_letters - @user_guesses).empty?
  end

  def word
    return @letters.join
  end
end
