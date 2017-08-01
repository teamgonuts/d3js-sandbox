# frozen_string_literal: true

module FlickrHelper
  include HTTParty
  class FlickrAPI
    # Calls flickr.photo.search to get photos.
    # See documentation here: https://www.flickr.com/services/api/flickr.photos.search.html
    # Radial search is in kilometers
    # Timestamp needed to work with geo queries, grabs only photos from 2016
    def self.get_photos(size, lat, lng, page = 1, radius = 25, start_month = nil)
      api_key = Rails.application.secrets.flickr_api_key
      # secret = 'dae79e503dedacaa'
      # 2016 dates
      # make them here: https://www.epochconverter.com/
      months = {
        1 => '1451606400',
        2 => '1454284800',
        3 => '1456790400',
        4 => '1459468800',
        5 => '1462060800',
        6 => '1464739200',
        7 => '1467331200',
        8 => '1470009600',
        9 => '1472688000',
        10 => '1475280000',
        11 => '1477958400',
        12 => '1480550400',
        13 => '1483228800'
      }
      method_name = 'flickr.photos.search'
      request_format = 'json'
      max_photos = 100000
      license = nil


      case size
      when 'thumbnail'
        size_url = 'url_t' # Thumbnail, 100 on longest side
      when 'small'
        size_url = 'url_n' # Small, 320 on longest side
      when 'medium'
        size_url = 'url_z' # Medium, 640 on longest side
      when 'original'
        size_url = 'url_o' # Original
      else
        raise Exceptions::InvalidParameters
      end

      # Sends request to the REST endpoint & requests JSON
      #url = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=b352bdbfb32a1ecdb35af15c9ea0c73e&safe_search=1&content_type=1&has_geo=1&lat=-33.4456328&lon=-70.6157308&radius=25&extras=date_upload%2Cdate_taken%2Cgeo%2Cowner_name&page=36&format=json&nojsoncallback=1&auth_token=72157684360566824-dde8fff2046f3316&api_sig=873524e4009c855ee90c0d2b995a2e54"
      url = "https://api.flickr.com/services/rest/?method=#{method_name}&format=#{request_format}&api_key=#{api_key}&media=photos&has_geo=1&content_type=1&lat=#{lat}&lon=#{lng}&radius=#{radius}&extras=geo,owner_name,date_upload,date_taken&safe_search=1&page=#{page}&nojsoncallback=1"
      url += "&min_taken_date=#{months[start_month]}&max_taken_date=#{months[start_month+1]}" if start_month
      url += "&license=#{license}" if license
      puts "Calling #{url}"
      return HTTParty.get(url, timeout: 10)
    end

    # gets info for photos
    def self.get_info
      api_key = Rails.application.secrets.flickr_api_key
      #https://api.flickr.com/services/rest/?method=flickr.photos.getInfo&api_key=XXXX&photo_id=35507210843&format=json&nojsoncallback=1&auth_token=72157684360566824-dde8fff2046f3316&api_sig=41eb1dfc55f2344cd8ff25b32ba0df10
    end

    def self.get_user_profile(user_id)
      api_key = Rails.application.secrets.flickr_api_key
      method_name = 'flickr.urls.getUserProfile'
      request_format = 'json'
      # Sends request to the REST endpoint & requests JSON
      url = "https://api.flickr.com/services/rest/?method=#{method_name}&format=#{request_format}&api_key=#{api_key}&nojsoncallback=1&user_id=#{user_id}"
      begin
        response = HTTParty.get(url, timeout: 10)
      rescue Net::ReadTimeout
        response = nil
      end
      return response
    end
  end
end
