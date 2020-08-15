require_all 'lib'

class Recording
  include FtpAgent

  attr_acessor :title, :description, :price, :date, :filepath
  attr_read :filename, :photoname

  def initalize (title, description, price, date, filepath, photopath, sq_photopath)
    @title = title
    @description = description
    @price = price
    @date = date
    @filepath = filepath
    @photopath = photopath
    @sq_photopath = sq_photopath
    @filename = @filepath.split('/')[-1].to_s
    @photoname =  @photopath.split('/')[-1].to_s
  end
  
end
