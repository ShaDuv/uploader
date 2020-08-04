require "mechanize"
require "Nokogiri"
require "Dotenv"
require "net/ftp"

class UploadAgent
  def initialize
    Dotenv.load
    @agent = Mechanize.new
    @file_path = '/Users/shawnaduvall/Downloads/GOLDEN BG 01.mp4'
    @file_name = @file_path.split('/')[-1]
  end

  def login
      userid = ENV['username']
      password = ENV['password']
      login_page = @agent.get 'http://niteflirt.com/login'
      # log in passing in username and pasword
      form = login_page.forms_with(action: 'https://www.niteflirt.com/login')
      form[0].field_with(:name => 'login').value = userid
      form[0].field_with(:name => 'password').value = password
      # return the results of loging in
      form[0].submit
    end

    def file_add
      filemanager = @agent.get 'https://www.niteflirt.com/account/filemanager'
      upload_form = filemanager.forms_with(id: 'fileupload')
    end

    def confirm
      puts @agent.page.uri
    end
  end 

  a = UploadAgent.new
  a.ftp_add

