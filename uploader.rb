require "mechanize"
require "Nokogiri"
require "json"
require "Dotenv"

class UploadAgent
  def initialize
    @agent = Mechanize.new
  end

  def login
      Dotenv.load
      userid = ENV['username']
      password = ENV['password']
      login_page = @agent.get 'https://iwantclips.com/home/login?redirect=https://iwantclips.com/'
      # log in passing in username and pasword
      form = login_page.forms_with(id: 'login_form')
      form[0].field_with(:name => 'email').value = userid
      form[0].field_with(:name => 'password').value = password
      # return the results of loging in
      form[0].submit
    end
    
    def add
      page = @agent.get 'https://iwantclips.com/content_factory/videos/add'
    end

    def confirm
      puts @agent.page.uri
    end
  end

  a = UploadAgent.new
  a.login
  a.add
  a.confirm

