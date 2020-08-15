require 'Dotenv'
require 'net/ftp'

module FtpAgent
  
  def ftp_add
      Dotenv.load
      ftp = Net::FTP.new(ENV['ftp_server'] , ENV['ftp_username'], ENV['ftp_password'])
      ftp.put @file_path
      ftp.put @webphoto
      puts ftp.list('*')
    end

    def ftp_delete
      ftp = Net::FTP.new(ENV['ftp_server'] , ENV['ftp_username'], ENV['ftp_password'])
      ftp.delete @file_name
      ftp.delete @webphoto
      puts ftp.list('*')
    end
end