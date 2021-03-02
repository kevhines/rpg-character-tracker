require './config/environment'

use Rack::MethodOverride
use NotesController
use GoodsController
use UsersController
run ApplicationController
