require "watir"
require 'selenium-webdriver'

class IWCAgent
  def initialize
    Dotenv.load
    Watir.default_timeout = 60
    @agent = Watir::Browser.new
    @file_path = '/Users/shawnaduvall/Downloads/1.mp3'
    @file_name = @file_path.split('/')[-1].to_s
    @sqphoto = '/Users/shawnaduvall/Downloads/1.jpg'
    @sqphoto_name = @sqphoto.split('/')[-1].to_s
  end


def login
  userid = ENV['username']
  password = ENV['nfpassword']
  @agent.goto('http://niteflirt.com/login')
  @agent.text_field(name: 'login').set(userid)
  @agent.text_field(name: 'password').set(password)
  @agent.button(name: 'commit').click
end

end