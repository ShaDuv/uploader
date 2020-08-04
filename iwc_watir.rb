require "Watir"
require "Dotenv"
require "net/ftp"

class UploadAgent
  def initialize
    Dotenv.load
    @agent = Watir::Browser.start 'https://iwantclips.com/home/login?redirect=https://iwantclips.com/'
    @file_path = '/Users/shawnaduvall/Downloads/GOLDEN BG 01.mp4'
    @file_name = @file_path.split('/')[-1]
  end

  def login
      userid = ENV['username']
      password = ENV['password']
      # log in passing in username and pasword
      u = @agent.text_field name: 'email'
      p = @agent.text_field name: 'password'

      u.set userid
      p.set password
      # return the results of loging in
      btn = @agent.button id: 'loginBtn'
      btn.click
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
      link = @agent.link text: "Sell Items"
      link.click

      link = @agent.link text: "Add a Video"
      link.click

      title = @agent.text_field name: 'title'
      title.set "Test"

      description = @agent.textarea name: 'description'
      description.set "This is a test upload."

      category = @agent.select_list id: 'category'
      

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

