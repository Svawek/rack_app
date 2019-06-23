require_relative 'app'
require_relative 'middleware/view_time'

use ViewTime
run App.new
