require_relative "./config/environment"

use RACK::JSONBodyPaarser

run Application.new