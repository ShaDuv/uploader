require "Watir"
require "Dotenv"
require "net/ftp"
require "capybara"

class UploadAgent
  def initialize
    Dotenv.load
    @agent = Watir::Browser.start 'https://iwantclips.com/home/login?redirect=https://iwantclips.com/'
    @file_path = '/Users/shawnaduvall/Downloads/GOLDEN BG 01.mp4'
    @file_name = @file_path.split('/')[-1].to_s
  end

  def login
      userid = ENV['username']
      password = ENV['password']
      # log in passing in username and pasword
      @agent.text_field(name: 'email').set(userid)
      @agent.text_field(name: 'password').set(password)
      @agent.button(id: 'loginBtn').click
      
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
      filename = @file_name
      #navigate to form
      @agent.link(text: "Sell Items").click!
      @agent.link(text: "Add a Video").click!
      @agent.text_field(name: 'title').set("Test")
      @agent.text_field(name: 'price').set("999")
      @agent.textarea(name: 'description').set("This is a test upload.")
      @agent.radio(value: 'later').set
      @agent.checkbox(name: "useTwitter").uncheck
      @agent.radio(name: 'status', value: '5').set
      @agent.radio(name: 'is_private', value: "0").set
      @agent.checkbox(name: 'model_agreement').check
       
      # date format is 8/3/2020, 10:14:36 PM
      # date has to be entered last until I figure out how to close the date selector box
      @agent.text_field(name: 'publish_time').set("8/3/2020, 10:14:36 PM")

      #add video and preview (currently preview will not actually generate and gets stuck on loop)
      @agent.link(text: 'Choose FTP File').click
      @agent.radio(name: 'image_radio', value: filename).set
      @agent.button(text: "Launch Preview Generator").click
      @agent.checkbox(name: "preview_image").click

      @agent.button(id: 'savebtn').click


      #Not currently working
      #category = @agent.select_list id: 'category', and keywords

    end

    def confirm
      puts @agent.page.uri
    end
  end 

  a = UploadAgent.new
  a.ftp_add

