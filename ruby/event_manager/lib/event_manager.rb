require "csv"
require "sunlight/congress"
require "erb"

Sunlight::Congress.api_key = "e179a6973728c4dd3fb1204283aaccb5"

def clean_zipcode(zipcode)
	zipcode.to_s.rjust(5, "0")[0..4]
end

def legislators_by_zipcode(zipcode)
	Sunlight::Congress::Legislator.by_zipcode(zipcode)
end

def save_thank_you_letters(id, form_letter)
	Dir.mkdir("output") unless Dir.exists? "output"

	filename = "output/thanks_#{id}.html"

	File.open(filename, "w") do |file|
		file.puts form_letter
	end
end

def clean_phone_number(phone_number, name)
	phone_number = phone_number.gsub(/\D/, "").to_s
	if phone_number.length != 10
		if phone_number.length == 11 && phone_number[0] == '1'
			phone_number = phone_number[1..-1]
		else
			phone_number = "0000000000"
		end
	end
	phone_number = phone_number[0..2]+"-"+phone_number[3..5]+"-"+phone_number[6..9]
	puts name+"   "+phone_number
end

def peak_registration_hours(reg_hours)
	puts "\n"
	peak_hours = reg_hours.inject(Hash.new(0)) { |h,v| h[v] += 1; h}
	peak_hours = peak_hours.sort_by { |h,v| v }.reverse

	peak_hours.each do |hour, count|
		puts "At #{hour}hour #{count} peoples registerd"
	end
	puts "\n"
end

def peak_registration_week_of_day(reg_days)
	peak_days = reg_days.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
	peak_days = peak_days.sort_by { |h,v| v }.reverse

	peak_days.each do |day, count|
		puts "At #{day} we have #{count} registrations"
	end
end

puts "EventManager Initialized"
puts "\n"

contents = CSV.open "event_attendees.csv", headers: true, header_converters: :symbol
template_letter = File.read "form_letter.erb"
erb_template = ERB.new template_letter

reg_hours = []
reg_days = []

contents.each_with_index do |col, index|
	id = col[0]
	phone_number = clean_phone_number(col[:homephone], col[:first_name])
	name = col[:first_name]
	zipcode = clean_zipcode(col[:zipcode])
	date_time = DateTime.strptime(col[:regdate], "%m/%d/%y %H:%M")
	reg_hours[index] = date_time.hour
	reg_days[index] = date_time.strftime('%A')
	legislators = legislators_by_zipcode(zipcode)
	form_letter = erb_template.result(binding)
	save_thank_you_letters(id, form_letter)
end

peak_registration_hours(reg_hours)
peak_registration_week_of_day(reg_days)