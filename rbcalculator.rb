@mainmenu = [
  "New Running Calculation",
  "Inline Calculation",
  "Exit Calculator"
]
@calcmenu = [
  "Clear Calculation",
  "Exit Calculator"
]
@carry_value = 0

def do_math(arg1, op, arg2)
  @arg1 = arg1
  @op = op
  @arg2 = arg2  
  if @op == '+'
    answer = @arg1 + @arg2
  elsif @op == '-'
    answer = @arg1 - @arg2
  elsif @op == '*'
    answer = @arg1 * @arg2
  elsif @op == '/'
    answer = @arg1 / @arg2
  end
  @carry_value = answer
  puts "#{@arg1} #{@op} #{@arg2} = #{@carry_value}"
end

def nl
  puts "\n"
end

def first_try
  nl
  puts "*" * 12
  nl
  print "Enter a first number for the calculation (or an option from the menu):"
  menu(@calcmenu)
  @arg1 = gets.strip
  nl
  @arg1
  print "Choose an operator (or an option from the menu):"
  @op = gets.strip
  nl
  print "Now, the second argument (or an option from the menu):"
  @arg2 = gets.strip
  nl
  puts "To try: #{@arg1} #{@op} #{@arg2}"
end

def second_on
  @arg1 = @carry_value
  nl
  print "Choose an operator (or an option from the menu):"
  @op = gets.strip
  nl
  print "Now, the second argument (or an option from the menu):"
  @arg2 = gets.strip
  nl
  puts "To try: #{@arg1} #{@op} #{@arg2}"
  nl
  do_math(@arg1, @op, @arg2)
end

def new_running
  while true
    first_try
    #error checking and routing
    if !['+', '-', '*', '/'].include?(@op)
      puts "!" * 12
      puts "Illegal argument. Please try only '-, +, *, or /' operators.'"
    elsif (['a', 'b'].include?(@arg1) || ['a', 'b'].include?(@arg2))
      #special options
      if (@arg1 == 'a' || @arg2 == 'a') 
        puts "Clearing calculations."  
      end
      if (@arg1 == 'b' || @arg2 == 'b') 
        puts "Exiting program"
        exit
      end
    else
      print "Calculating..."

      while !['a', 'b'].include?(@arg1) && !['a', 'b'].include?(@arg2)
        second_on
        @carry_value = do_math(@arg1.to_f, @op, @arg2.to_f)
        puts "#{@arg1} #{@op} #{@arg2} = #{@carry_value}"
      end
      if (@arg1 == 'a' || @arg2 == 'a') 
        puts "Clearing calculations."
        break
      end
      if (@arg1 == 'b' || @arg2 == 'b') 
        puts "Exiting program"
        exit
      end
    end
  end
end

def inline
  puts "Sorry, this functionality has not been built yet."
end

def main_parser
  answer = gets.strip
  #logic tree
  if !['a', 'b', 'c'].include?(answer)
    puts "I can't do that, Dave."
    exit
    elsif answer == 'a'
      new_running
    elsif answer == 'b'
      inline
    elsif answer == 'c'
      puts "You twisted my arm."
      exit
  end
end

def menu(menuname)
  #initialize a few variables and put a blank space in
  letters = ['a', 'b', 'c']; i = 0; puts "\n"
  #loop through the arrays and format the menu
  while i < (menuname.length)
    puts "#{letters[i]}) #{menuname[i]}"
    i += 1
  end
end

#main program loop
while true
  menu(@mainmenu)
  main_parser
end