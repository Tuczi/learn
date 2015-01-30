#!/bin/ruby

require "yaml"
require "set"
require "colorize"

def main
  system "clear"
  data = YAML.load_file("data.yml")
  while true
    question = next_question(data)
    puts question["text"].colorize(:light_blue)
    
    correct_answers =print_answers(question)
    #puts correct_answers.to_s.colorize(:light_red) #debug
    input =  gets.chomp
    system "clear"
    if correct?( correct_answers, input)
      puts "OK".colorize(:green)
    else 
      puts "NOT OK".colorize(:red)
      puts question["text"].colorize(:light_blue)
      print_correct(question);
      print "Press any key"
      gets.chomp
      system "clear"
    end
  end
end

def next_question(data)
  data[rand(data.length)]["question"]
end

def print_correct(question)
  question["correct"].each do |a|
    puts "-\t#{a}".colorize(:green)
  end
end

def print_answers(question)
  i = 0
  n = question["correct"].length + question["wrong"].length
  tmp = Range.new(0, n -1).to_a.shuffle
  answers = Array.new(n-1)
    
  result = []
  question["correct"].each do |a|
    answers[tmp[i]] = a
    result.push "#{tmp[i]}"
    i = i +1
  end
  question["wrong"].each do |a|
    answers[tmp[i]] = a
    i = i +1
  end
  
  i = 0
  answers.each do |a|
    puts "#{i})\t#{a}"
    i = i + 1
  end
  
  result
end

def correct?(correct_answers, input)
  Set.new(correct_answers).eql? Set.new(input.split(' '))
end

main
