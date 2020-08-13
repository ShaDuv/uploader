require 'watir'
require 'Dotenv'
require 'net/ftp'
require 'selenium-webdriver'

class UploadAgent
  def initialize
    Dotenv.load
    Watir.default_timeout = 60
    @agent = Watir::Browser.new
    @file_path = '/Users/shawnaduvall/Downloads/1.mp3'
    @file_name = @file_path.split('/')[-1].to_s
    @wide_photo = '/Users/shawnaduvall/Downloads/1.jpg'
    @wide_photo_name = @wide_photo.split('/')[-1].to_s
  end

  def login
      userid = ENV['username']
      password = ENV['password']
      # log in passing in username and pasword
      @agent.goto('https://iwantclips.com/home/login?redirect=https://iwantclips.com/')
      @agent.text_field(name: 'email').set(userid)
      @agent.text_field(name: 'password').set(password)
      @agent.button(id: 'loginBtn').click
      
    end

    def ftp_add
      Dotenv.load
      ftp = Net::FTP.new(ENV['ftp_server'] , ENV['ftp_username'], ENV['ftp_password'])
      ftp.put @file_path
      ftp.put @wide_photo
      puts ftp.list('*')
    end

    def ftp_delete
      ftp = Net::FTP.new(ENV['ftp_server'] , ENV['ftp_username'], ENV['ftp_password'])
      ftp.delete @file_name
      ftp.delete @wide_photo
      puts ftp.list('*')
    end

    def add
      filename = @file_name
      filepath = @filepath
      wide_photo = "/#{@wide_photo_name}"
      @agent.link(text: 'Sell Items').click!
      @agent.link(text: 'Add a PDF/Doc/Audio').click!
      @agent.text_field(name: 'title').wait_until(&:present?).set('Test')
      @agent.text_field(name: 'price').set('999')
      @agent.textarea(name: 'description').set('This is a test upload.')
      @agent.radio(value: 'later').set
      @agent.checkbox(name: 'useTwitter').uncheck
      @agent.radio(name: 'publish_status', value: 'later').set
      @agent.radio(name: 'is_private', value: '0').set
      @agent.checkbox(name: 'model_agreement').check
      @agent.ul(class: 'chzn-choices').click!
      @agent.text_field(value: 'Select').set('Mesmerize')
      @agent.send_keys :enter
      @agent.ul(class: 'chzn-choices').click!
      @agent.text_field(value: 'Select').set('Audio Only')
      @agent.send_keys :enter
      @agent.radio(name: 'status', value: '0').set
      
      @agent.link(href: 'https://iwantclips.com/content_factory/items/choose_ftp_file').click!
      p 'Choose FTP'
      sleep(10)
      p @agent.radio(name: 'image_radio', value: filename).exists?
      @agent.radio(name: 'image_radio', value: filename).set
      sleep(5)
      p 'select mp3'
      @agent.link(href: 'https://iwantclips.com/content_factory/items/choose_ftp_prevew').click!
      sleep(5)
      p @agent.radio(name: 'image_radio', value: wide_photo).exists?
      @agent.radio(name: 'image_radio', value: wide_photo).set
      p 'selectjpg'
      @agent.text_field(name: 'publish_time').set('12/13/2020, 10:14:36 PM')
      @agent.send_keys :enter
      p 'date'
      sleep(3)
      @agent.button(id: 'savebtn').click!
    end
  end 

  a = UploadAgent.new
  #a.ftp_delete
  #a.ftp_add
  a.login
  a.add

