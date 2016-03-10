class Game

	def initialize
		@supporter_team = Hash.new{ |team, supporter| team[supporter] = [] }
		@points_table = Hash.new
		@reporter_channel = Hash.new
	end

	def split_teams(teams)
		teams = teams.split(" ")
		teams.each do |team_name|
			team_name = team_name.downcase.gsub(/[^a-z]/, "")
			generate_points_table(team_name)
		end
	end

	def split_supporter_name_team(supporter)
		supporter = supporter.split(",")
		team = supporter[1].downcase.gsub(/[^a-z]/, "")
		supporter = supporter[0].downcase.gsub(/[^a-z]/, "")
		if check_if_team_is_valid(team)
			map_supporter_to_team( supporter, team )
		else
			puts "\nteam spelling is wrong or team specified is not playing"
			return false
		end
	end

	def split_reporter_name_channel(reporter)
		reporter_channel = reporter.split(",")
		reporter_name = reporter_channel[0].downcase.gsub(/[^a-z]/, "")
		map_reporter_channel(reporter_name, reporter_channel[1])
	end

	def situation_analyze(situation)
		express_feelings(situation)
	end

	private

	def generate_points_table(team)
		@points_table[team] = 0
	end
	
	def check_if_team_is_valid(team)
		@points_table.key?(team)
	end
	
	def map_supporter_to_team(supporter_name, team)
		@supporter_team[team].push(supporter_name)
	end

	def map_reporter_channel(reporter_name, channel)
		@reporter_channel[channel] = reporter_name
	end

	def express_feelings(situation)
		if situation.downcase.gsub(/[^a-z]/, "") == "gameover"
			check_for_match_draw
			winning_team = ''
			loser_team = ''
			@points_table.each do |team, goals|
				if goals == @points_table.values.max
					winning_team = team
					feeling = " Yes! "+team.capitalize+" won."
				else
					loser_team = team
					feeling = " Alas! "+team.capitalize+" lost."
				end
				supporter_feeling(feeling, team)
			end
			news_report(winning_team, loser_team, 0)
			exit 0
		else
			situation = situation.split(":")
			team = situation[1].downcase.gsub(/[^a-z]/, "")
			if check_if_team_is_valid(team)
				refresh_points_table(team)
				@supporter_team.each do |team_name, name|
					if team_name == team
						supporter_feeling(": Hurrah!", team_name)
					else
						supporter_feeling(": Alas!", team_name)
					end
				end
				news_report(team,'', 1)
			else
				puts "team spelling is wrong or team specified is not playing"
				return false
			end
		end
	end

	def check_for_match_draw
		points = @points_table.values
		unless points.length == points.uniq.length then
			puts "Match Drawn"
			exit 0
		end
	end

	def supporter_feeling(feeling, team)
		@supporter_team[team].each do |supporter|
			puts "\n#{supporter.capitalize} says#{feeling}"
		end
	end

	def refresh_points_table(team)
		goals_count = @points_table[team]
		@points_table[team] = goals_count + 1
	end

	def news_report(winning_team, loser_team, i)
		time = Time.now.strftime("%I:%M %p")
		@reporter_channel.each do |channel, reporter|
			puts "\n#{reporter.capitalize} reports: #{winning_team.capitalize} has won the game against #{loser_team.capitalize} by #{@points_table[winning_team]} - #{@points_table[loser_team]} . Brought to you by #{channel}" if i == 0
			puts "\n#{reporter.capitalize} reports: #{winning_team.capitalize} has scored a goal at #{time}. Brought to you by #{channel}" if i == 1
		end
	end

end

class Interface

	foot_ball = Game.new
	
	puts "Enter the team names and separate them with space (No space in team name ex:- NewZealand not New Zealand)"
	teams = gets.chomp!
	foot_ball.split_teams(teams)
	
	supporters_and_reporters = ''
	begin
		puts "\nEnter the number of supporters and number of reporters   (use space seperator)"
		supporters_and_reporters = gets.chomp!
		supporters_and_reporters = supporters_and_reporters.split(" ")
	end while supporters_and_reporters.length != 2

	supporters_count = supporters_and_reporters[0].to_i
	reporters_count = supporters_and_reporters[1].to_i

	supporters_count.times do |i|
		validate = true
		begin
			puts "\nGive the supporter#{i+1} name and team name   (use comma seperator)"
			supporter = gets.chomp!
			validate = foot_ball.split_supporter_name_team(supporter)
		end while validate == false	
	end

	reporters_count.times do |i|
		puts "\nGive the news reporter#{i+1} name and channel name   (use comma seperator)"
		reporter = gets.chomp!
		foot_ball.split_reporter_name_channel(reporter)
	end

	while true
		validate = true
		begin 
			puts "\nEnter the current situation of game"
			situation = gets.chomp!
			validate = foot_ball.situation_analyze(situation)
		end while validate == false
	end

end