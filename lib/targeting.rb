require 'csv'
require 'time'

def print_frequency(hash)
  puts hash.sort_by { |key, value| -value }.to_h
end

contents = CSV.open(
  'event_attendees.csv',
  headers: true,
  header_converters: :symbol
)

dates = []
hours = []
days_of_week = %w[sunday monday tuesday wednesday thursday friday saturday]

puts 'Registration dates, times, and weekday'

contents.each do |row|
  reg_date_time = row[:regdate]
  reg_date_time = reg_date_time.split(/[\D, \s]/)
  year   = '20' + reg_date_time[2]
  month  = reg_date_time[0]
  day    = reg_date_time[1]
  hour   = reg_date_time[3]
  minute = reg_date_time[4]
  time = Time.new(year, month, day, hour, minute, 0, 0)

  dates.push("#{month}/#{day}")
  hours.push("#{hour}")
  days_of_week.push(days_of_week[time.wday])

  puts "#{year}/#{month}/#{day} #{time.hour}:#{time.min} #{days_of_week[time.wday]}"
end

common_dates = dates.tally
common_hours = hours.tally
common_week_days = days_of_week.tally

puts "===\n"
puts 'common_dates by frequency:'
puts print_frequency(common_dates)

puts "===\n"
puts 'common_hours by frequency:'
puts print_frequency(common_hours)

puts "===\n"
puts 'common_week_days by frequency:'
puts print_frequency(common_week_days)
puts "\n"
# puts common_week_days
