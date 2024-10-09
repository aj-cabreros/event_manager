require 'csv'

def clean_number(phone_number)
  # Remove all non-numeric characters
  trimmed_number = phone_number.tr('^0-9', '')

  if trimmed_number.length == 10
    trimmed_number
  elsif trimmed_number.length == 11
    if trimmed_number[0] == '1'
      trimmed_number[1..]
    else
      '0000000000'
    end
  elsif trimmed_number.length < 10 || trimmed_number.length > 11
    '0000000000'
  end
end

def format_number(phone_number)
  if phone_number == '0000000000'
    'unavailable'
  else
    "(#{phone_number[0..2]}) #{phone_number[3..5]}-#{phone_number[6..9]}"
  end
end

def save_name_and_phone(name_and_phone_string)
  filename = 'phone_list.txt'

  File.open(filename, 'a') do |file|
    file.puts name_and_phone_string
  end
end

puts 'Clean Phone Numbers Initialized'

if File.exist? 'event_attendees.csv'
  contents = CSV.open(
    'event_attendees.csv',
    headers: true,
    header_converters: :symbol
  )

  contents.each do |row|
    name = row[:first_name]
    csv_numbers = row[:homephone]
    # puts phone_number.is_a?(String)
    numerics_only = clean_number(csv_numbers)
    formatted = format_number(numerics_only)
    str = "#{name} || #{formatted}"
    save_name_and_phone(str)
    puts str
  end

  puts 'output appended to "phone_list.txt"'

end
