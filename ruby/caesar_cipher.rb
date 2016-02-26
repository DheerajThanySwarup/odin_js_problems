=begin 
In cryptography, a Caesar cipher, also known as Caesar's cipher, the shift cipher, 
Caesar's code or Caesar shift, is one of the simplest and most widely known encryption techniques. 
It is a type of substitution cipher in which each letter in the plaintext is replaced by a letter 
some fixed number of positions down the alphabet. For example, with a left shift of 3, D would be
replaced by A, E would become B, and so on. 
The method is named after Julius Caesar, who used it in his private correspondence.
=end

class Cryptography
    
	def caesar_cipher( input_string, shift_factor )
	    output_string = ""
		input_string.each_byte do |letter|
		    if letter < 91
			    output_string << generate_cipher(65,90,letter,shift_factor)
			else
			    output_string << generate_cipher(97,122,letter,shift_factor)
			end
		end
		return output_string
	end
	
	def generate_cipher( lower_bound, upper_bound, letter, shift_factor )
	    if letter >= lower_bound && letter <= upper_bound
				letter = letter + shift_factor
				if letter > upper_bound
					letter = letter - 26
				elsif letter < lower_bound
					letter = letter + 26
				end
		end
	    return letter.ord.chr
	end

end

plain_text = Cryptography.new
puts "Enter the plain text"
input_string = gets.chomp!
puts "Enter the shift factor"
key = gets.to_i
cipher = plain_text.caesar_cipher(input_string, key)
puts "The cipher is '#{cipher}' "