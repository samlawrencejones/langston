require 'curses'

class CursesPrinter

	def initialize(x_size, y_size)
		@x_size = x_size
		@y_size = y_size
		Curses.noecho
		Curses.init_screen
		Curses.start_color
		Curses.curs_set(0)
		Curses.init_pair(color_key(:white), Curses::COLOR_BLACK, Curses::COLOR_WHITE)
		Curses.init_pair(color_key(:black), Curses::COLOR_BLACK, Curses::COLOR_BLACK)
		Curses.init_pair(color_key(:green), Curses::COLOR_BLACK, Curses::COLOR_GREEN)
		Curses.init_pair(color_key(:blue), Curses::COLOR_BLACK, Curses::COLOR_BLUE)
		Curses.init_pair(color_key(nil), Curses::COLOR_RED, Curses::COLOR_BLACK)
		@win = Curses::Window.new(x_size, y_size, 0, 0)
	end
	def self.open_with_size(x_size, y_size)
		CursesPrinter.new(x_size, y_size)
	end

	def print(x, y, value)
		@win.setpos(x, y)
		@win.color_set(color_key(value))
		@win.addch(get_character(value))
	end

	def refresh
		sleep(0.15)
		@win.refresh
	end

	private
		def get_character(value)
			case value
			when :north
				'^'		
			when :south
				'v'
			when :east
				'>'
			when :west
				'<'
			else
				" "
			end
		end

		private
			def color_key(color)
				case color
				when :white
					1
				when :black
					2
				when :green
					3
				when :blue
					4
				else
					5
				end
			end
end
