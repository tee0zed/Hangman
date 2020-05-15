require 'colorize'

class ConsoleInterface
  FIGURES = Dir['./data/figures/*.txt'].sort.map { |file_name| File.read(file_name) }

  def initialize(game)
    @game = game
  end

  def print_out
    puts "Слово: #{word_to_show}".colorize(:green)
    puts "#{figure}".colorize(:yellow)
    puts "Ошибки (#{@game.errors_made}): #{errors_to_show}
      У вас осталось ошибок: #{@game.errors_allowed}
      ".colorize(:red)

    if @game.won?
      puts "Поздравляем, вы выиграли!".colorize(:green)
    elsif @game.lost?
      puts "Вы проиграли, загаданное слово: #{@game.word}".colorize(:red)
    end
  end

  def figure
    return FIGURES[@game.errors_made]
  end

  def word_to_show
    result =
      @game.letters_to_guess.map do |letter|
        if letter == nil
          "__"
        else
          letter
        end
      end

    return result.join(' ')
  end

  def errors_to_show
    return @game.errors.join(', ').colorize(:red)
  end

  def get_input
    print "Введите следующую букву: ".colorize(:white)
    letter = gets[0].upcase

    letter = "Е" if letter == "Ё"
    letter = "И" if letter == "Й"

    return letter
  end
end
