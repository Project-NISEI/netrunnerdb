class ImagesController < ApplicationController
  def serve
    nr_set = params[:nr_set]
    code = params[:code]
    path = "../netrunner-scans/#{nr_set}/#{code}.jpg"
    p path

    send_file(path, disposition: 'inline', type: 'image/jpeg', x_sendfile: true)
  end
end
