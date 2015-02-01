class Manager
  attr_accessor :questions, :questions_asked_counter

  def initialize(data)
    @questions = data.map { |d| Question.new(d['question']) }
    @questions_asked_counter = 0
  end

  def call
    until questions.empty?
      @questions_asked_counter += 1
      system 'clear'
      question = next_question
      input = gets.chomp
      system 'clear'
      remove(question) if answer_ok?(input, question)
      question.display_correct
      puts 'Press any key'
      gets.chomp
    end
    puts "Congrats! It took you #{questions_asked_counter} questions."
  end

  private

  def next_question
    q = questions.sample
    q.shuffle!
    q.display
    q
  end

  def answer_ok?(input, question)
    if question.valid?(input.split(' ').map(&:to_i).sort)
      puts 'OK'.colorize(:green)
      true
    else
      puts 'NOT OK'.colorize(:red)
      false
    end
  end

  def remove(question)
    questions.delete(question)
    puts "There are #{questions.count} questions left."
  end
end
