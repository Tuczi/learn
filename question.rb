require 'colorize'

class Question
  attr_accessor :answers, :text, :correct_answers_ids

  def initialize(params)
    @answers = params['correct'].map { |q| [true, q] } +
               params['wrong'].map { |q| [false, q] }
    @text = params['text']
    @correct_answers_ids = []
  end

  def shuffle!
    answers.shuffle!
    mark_correct_answers
  end

  def display
    puts text.colorize(:light_blue)
    answers.each_with_index { |a, i| display_answer(i, a, :white) }
  end

  def display_correct
    puts text.colorize(:light_blue)
    answers.each_with_index { |a, i| (display_answer(i, a, :green) if a[0]) }
  end

  def valid?(answer)
    correct_answers_ids == answer
  end

  private

  def display_answer(i, answer, color)
    puts "#{i + 1})\t#{answer[1]}".colorize(color)
  end

  def mark_correct_answers
    @correct_answers_ids = []
    answers.each_with_index { |a, i| (@correct_answers_ids << (i + 1) if a[0]) }
  end
end
