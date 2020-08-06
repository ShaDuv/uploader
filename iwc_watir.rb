require "Watir-webdriver"
require "Dotenv"
require "net/ftp"
require "capybara"

class UploadAgent
  def initialize
    Dotenv.load
    Watir::Browser.new :firefox 
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
      filepath =
      #navigate to form
      @agent.link(text: "Sell Items").click!
      @agent.link(text: "Add a Video").click!
      @agent.text_field(name: 'title').wait_until(&:present?).set("Test")
      @agent.text_field(name: 'price').set("999")
      @agent.textarea(name: 'description').set("This is a test upload.")
      @agent.radio(value: 'later').set
      @agent.checkbox(name: "useTwitter").uncheck
      @agent.radio(name: 'status', value: '5').set
      @agent.radio(name: 'is_private', value: "0").set
      @agent.checkbox(name: 'model_agreement').check
      @agent.ul(class: "chzn-choices").click!
      @agent.text_field(value: "Select").set("Mesmerize")
      @agent.send_keys :enter
      @agent.ul(class: "chzn-choices").click!
      @agent.text_field(value: "Select").set("Audio Only")
      @agent.send_keys :enter
      @agent.link(text: 'Choose FTP File').click!
      @agent.radio(name: 'image_radio', value: filename).set
      @agent.button(text: "Launch Preview Generator").wait_until(&:present?).click!
      @agent.checkbox(id: "preview_image").check
      @agent.button(id: "save-btn").click!
      @agent.button(id: "save-preview-btn").wait_until(&:present?).click!
      @agent.text_field(name: 'publish_time').set("12/13/2020, 10:14:36 PM")
      @agent.button(id: 'savebtn').wait_until(&:present?).click!
    end

    def confirm
      puts @agent.page.uri
    end
  end 

  a = UploadAgent.new
  a.ftp_add

