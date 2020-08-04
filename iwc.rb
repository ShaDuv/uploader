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
      login_page = @agent.get 'https://iwantclips.com/home/login?redirect=https://iwantclips.com/'
      # log in passing in username and pasword
      form = login_page.forms_with(id: 'login_form').first
      form.field_with(:name => 'email').value = userid
      form.field_with(:name => 'password').value = password
      # return the results of loging in
      form.submit
    end

    def ftp_add
      ftp = Net::FTP.new(ENV['ftp_server'] , ENV['ftp_username'], ENV['ftp_password'])
      ftp.put @file_path
      puts ftp.list('*')
    end

    def ftp_delete
      ftp = Net::FTP.new(ENV['ftp_server'] , ENV['ftp_username'], ENV['ftp_password'])
      ftp.delete @file_name
      puts ftp.list('*')
    end

    def add
      page = @agent.get 'https://iwantclips.com/content_factory/videos/add'
      form = page.forms_with(action: 'https://iwantclips.com/content_factory/videos/save').first
      form.field_with(name: 'title').value = "Test"
      form.field_with(name: 'description').value = "This is a test upload."
      form.field_with(name: 'category[]').value = ['Mesmerize', 'Audio Only']
      form.field_with(name: 'keywords[]').value = %w[ASMR Mindwash Addiction]
      form.checkbox(name: "useTwitter").uncheck
      form.radiobutton(name: 'twitterAttachment').value = "none"
      form.field_with(name: 'price').value = "15"
      form.radiobutton(name: 'status', value: '5').check
      form.radiobutton(name: 'is_private', value: "1").check
      form.radiobutton(name: 'is_private', value: "1").uncheck
      form.checkbox(name: 'model_agreement').check
      form.field_with(name: 'ftp_file').value = "GOLDEN BG 01.mp4"
      form.submit
    end

    def confirm
      puts @agent.page.uri
    end
  end 

  a = UploadAgent.new
  a.ftp_add

