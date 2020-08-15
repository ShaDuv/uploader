require "mechanize"
require "Nokogiri"
require "Dotenv"

class NFAgent
  def initialize
    Dotenv.load
    @agent = Mechanize.new
    @file_path = '/Users/shawnaduvall/Downloads/1.mp3'
    @file_name = @file_path.split('/')[-1]
  end

  def login
      userid = ENV['username']
      password = ENV['password']
      login_page = @agent.get 'http://niteflirt.com/login'
      # log in passing in username and pasword
      form = login_page.forms_with(action: 'https://www.niteflirt.com/login').first
      form.field_with(:name => 'login').value = userid
      form.field_with(:name => 'password').value = password
      # return the results of loging in
      form.submit
    end

    def goodybag
      goody = @agent.get 'https://www.niteflirt.com/account/filemanager#tab-goody'
      form = goody.forms_with(action: '/fm/profiles/11797491/goody_bags').first
      form.method = "POST"
      form.field_with(name: 'goody_bag[title]').value = "Test"
      form.field_with(name: 'goody_bag[price]').value = "99"
      form.field_with(name: 'goody_bag[go_live_date]').value = "2020-12-19"
      form.field_with(name: 'goody_bag[description]').value = "This is a test description"
      form.submit
    end

  end 

  a = NFAgent.new
  a.ftp_add

