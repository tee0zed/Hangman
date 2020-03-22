class Game
  TOTAL_ERRORS_ALLOWED = 7

  def initialize(word)
    @letters = word.upcase.chars
    @normalized_letters = normalized_letters(@letters)
    @user_guesses = []
  end

  def errors
    return @user_guesses - @normalized_letters
  end

  def errors_made
    return errors.length
  end

  def errors_allowed
    return TOTAL_ERRORS_ALLOWED - errors_made
  end

  def letters_to_guess
    @letters.map { |letter| letter if @user_guesses.include?(letter) }
  end

  def lost?
    errors_allowed == 0
  end

  def over?
    won? || lost?
  end

  def play!(letter)
    if !over? && !@user_guesses.include?(normalize_letter(letter))
      @user_guesses << normalize_letter(letter)
    end
  end

  def won?
    (@normalized_letters - @user_guesses).empty?
  end

  def word
    @letters.join
  end

  private

  def normalize_letter(letter)
    letter = "Е" if letter == "Ё"
    letter = "И" if letter == "Й"
    letter
  end

  def normalized_letters(letters)
    letters.map {|letter| normalize_letter(letter)}
  end
end
