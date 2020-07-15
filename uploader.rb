require "mechanize"
require "Nokogiri"
require "Dotenv"

class UploadAgent
  def initialize
    @agent = Mechanize.new
  end

  def login
      Dotenv.load
      userid = 'raynawalsh@gmail.com'
      password = 'Lzb74710019!'
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
      form = page.forms_with(action: 'https://iwantclips.com/content_factory/videos/save')
      form[0].field_with(name: 'title').value = "Test"
      form[0].field_with(name: 'description').value = "This is a test upload."
      form[0].field_with(name: 'category[]').value = ['Mesmerize', 'Audio Only']
      form[0].field_with(name: 'keywords[]').value = %w[ASMR Mindwash Addiction]
      form[0].checkbox(name: "useTwitter").uncheck
      form[0].radiobutton(name: 'twitterAttachment').value = "none"
      form[0].radiobutton(name: 'publish_status').value = "Later."
      form[0].field_with(name: 'price').value = "15"
      form[0].radiobutton(name: 'status').value = 5
      form[0].radiobutton(name: 'is_private').value = 1
      form[0].checkbox(name: 'model_agreement').checked
      form[0].field_with(name: 'file_name_1').value = '/Users/shawnaduvall/Downloads/1920_1080_IMG_2171.mov'
      form[0].submit
    end

    def confirm
      puts @agent.page.uri
    end
  end 

  a = UploadAgent.new
  a.login
  a.add
  a.confirm

