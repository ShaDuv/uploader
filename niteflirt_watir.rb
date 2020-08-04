require "watir"

site = Watir::Browser.start 'http://niteflirt.com/login'


def login
  u = site.text_field name: 'login'
  p = site.text_field name: 'password'
  btn = site.button name: 'commit'

  u.set 
  p.set 
  btn.click
end

def upload
  l = site.link text: 'MY ACCOUNT'
  fm = site.link text: 'File Manager'

  l.click
  fm.click

   upld_btn1 = site.button text: 'Upload'
   upld_btn1.click

   c = site.checkbox rel: "upload-confirmation"
   c.set

   files = site.span class: 'fileinput-button'
   files.click

