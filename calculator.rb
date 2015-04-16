puts "What is your first number?"
num1 = gets.chomp

puts "What is your second number?"
num2 = gets.chomp

loop do
  puts "Select your operation: 1) add 2) substract 3) multiply 4) divide"
  operation = gets.chomp
  if operation == "1"
    result = num1.to_i + num2.to_i
    puts "Result: #{num1} + #{num2} = #{result}"
    break
  elsif operation == "2"
    result = num1.to_i - num2.to_i
    puts "Result: #{num1} - #{num2} = #{result}"
    break
  elsif operation == "3"
    result = num1.to_i * num2.to_i
    puts "Result: #{num1} x #{num2} = #{result}"
    break
  elsif operation == "4"
    result = num1.to_f / num2.to_f
    puts "Result: #{num1} / #{num2} = #{result}"
    break
  else
    puts "Input either 1 , 2 , 3 and 4 for operation"
  end
end
