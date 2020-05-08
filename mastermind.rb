#require 'pry'

class Game
    @@guess_code = {}
    @@code = {}
    @colors = ["red", "yellow", "green", "blue", "brown", "black", "white", "orange"]
    @color_match = []
    @position_match = []

    def initialize
        @color = color
    end

    def self.start
        puts "--------------> M  A  S  T  E  R  M  I  N  D <--------------"
        puts "The computer is going to randomly assign a color to a random " +
        "position. You'll be guessing a 4 colors, in order. Blah Blah Blah" +
        "The Colors to choose from are:" 
        puts "Red, Green, Blue, Yellow, Brown, Black, White and Orange."
        puts "You have 12 tries to get it right or the computers are taking over! Good luck!" 
        sleep 1
        puts "Would you like to:"
        puts "1) Guess the Computer's code?"
        puts "2) Have the Computer guess your code?"
        puts "1 or 2"
        #The following assures that the user will provide a correct input
        until @players_choice == (1 || 2)
            @players_choice = gets.chomp.to_i
            if @players_choice == 1
                self.round
            elsif @players_choice == 2
                self.play
            else
                puts "You didn't pick the right number, dingus. Try again."
            end
        end
    end

    def self.computers_choice
      for i in 1..4
        @@code[i] = @colors[rand(0..7)]
      end
    end

    def self.correct_input
        puts "You either mistyped or put in a wrong color. Remember the colors are:"
        puts "Red, Green, Blue, Yellow, Brown, Black, White and Orange."
        until @colors.include?(@color)
            @color = gets.chomp.downcase.strip
            #binding.pry
        end
        @color
    end

    def self.round
        self.computers_choice
        #Loop allowing the User to make 12 attempts at guessing the Computer's code correctly.
        for i in 1..12
          puts "Attempts: #{i} of 12".rjust(10)
          puts "Alright, What do you think the 1st color is?"
                @color = gets.chomp.downcase.strip  
        #All this nonsense means is if the input doesn't match a color, it'll run the method self.correct_input
        #until the input is correct.
                @colors.include?(@color) ? @@guess_code[1] = @color : @@guess_code[1] = self.correct_input 
            puts "Ok, the second?"
                @color = gets.chomp.downcase.strip  
                @colors.include?(@color) ? @@guess_code[2] = @color : @@guess_code[2] = self.correct_input 
                puts "Ok, the third?"
                @color = gets.chomp.downcase.strip  
                @colors.include?(@color) ? @@guess_code[3] = @color : @@guess_code[3] = self.correct_input 
            puts "Ok, what do you think the last color is?"
                @color = gets.chomp.downcase.strip  
                @colors.include?(@color) ? @@guess_code[4] = @color : @@guess_code[4] = self.correct_input 
          puts "Ok. So your guesses are"
          puts "1. #{@@guess_code[1].capitalize} 2. #{@@guess_code[2].capitalize} 3. #{@@guess_code[3].capitalize} 4. #{@@guess_code[4].capitalize}."
            if @@guess_code == @@code
              puts "You got's it!"
              exit!
            end
        ##This next code is used to match colors between the computers choice and the user's input
          @@code.values.each { |color|
            if @@guess_code.values.include?(color)
              @color_match << color
            end
          } 
        ##This next code is used to see if the user correctly guessed the position of the color in the
        ##computer's code
          @@code.to_a.each { |match|
            if @@guess_code.to_a.include?(match)  
              @position_match << match
            end
          }
        puts "You got #{@color_match.length} colors correct!"
        puts "Plus you got #{@position_match.length} of the positions correct! Keep Going!"
        @color_match.clear
        @position_match.clear
        end
        puts "Well, it looks like you couldn't crack it. Computers are taking over now. Thanks a lot."
    end
    
    def self.play
        puts "Ok. So you want to try your brains against a computer? Good luck on that front, bucko"
        puts "What do you want your first color to be?"
        @color = gets.chomp.downcase.strip
        @colors.include?(@color) ? @@code[1] = @color : @@code[1] = self.correct_input 
        puts "Second color?"
        @color = gets.chomp.downcase.strip
        @colors.include?(@color) ? @@code[2] = @color : @@code[2] = self.correct_input
        puts "Third?"
        @color = gets.chomp.downcase.strip
        @colors.include?(@color) ? @@code[3] = @color : @@code[3] = self.correct_input
        puts "Ok, what's your last color?"
        @color = gets.chomp.downcase.strip
        @colors.include?(@color) ? @@code[4] = @color : @@code[4] = self.correct_input
        puts "Ok, your secret code is"
        puts "1.#{@@code[1].capitalize} 2.#{@@code[2].capitalize} 3.#{@@code[3].capitalize} 4.#{@@code[4].capitalize}."
        sleep 1
        puts "Let's see what the computer guesses"
        self.computers_guess
    end

    def self.computers_guess
        12.times{
            for i in 1..4
              unless @@guess_code[i] == @@code[i]
                @@guess_code[i] = @colors[rand(0..7)]
              end
            end
            puts "The computer guesses #{@@guess_code[1].capitalize}, #{@@guess_code[2].capitalize}, #{@@guess_code[3].capitalize} and #{@@guess_code[4].capitalize}."
            if @@guess_code == @@code
                puts "The computer won!"
                exit!
            end
            sleep 1
        }
        puts "Looks like you fooled the computer!"
        exit!
    end






end 

Game.start

