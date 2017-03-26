require "sinatra"
require "sinatra/reloader" if development?

def caesar_shift (input, shift=0)
  chars = input.split("")
  shift = shift.to_i
  i = 0
  chars.each do |char|
    ascii_code = char.ord.to_i
    if char =~ /[A-Za-z]/    # alphabetic character
      new_code = ascii_code + shift
      if shift > 0
        new_code -= 26 if ((char =~ /[A-Z]/ && new_code > 90) || new_code > 122)
      else
        new_code += 26 if ((char =~ /[a-z]/ && new_code < 97) || new_code < 65)
      end
    else             # all other characters
      new_code = ascii_code
    end
    chars[i] = new_code.chr
    i += 1
  end
  return chars.join
end

get "/" do
  erb :index


end

post "/" do

   message = params[:message].to_s
   shift_factor = params[:shift].to_i
   @shift_message = caesar_shift(message, shift_factor)
   erb :index
end
