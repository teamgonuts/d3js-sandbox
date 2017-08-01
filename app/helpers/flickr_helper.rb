# frozen_string_literal: true

module FlickrHelper
  include HTTParty
  class FlickrAPI
    # Calls flickr.photo.search to get photos.
    # See documentation here: https://www.flickr.com/services/api/flickr.photos.search.html
    # Radial search is in kilometers
    # Timestamp needed to work with geo queries, grabs only photos from 2016
    def self.get_photos(size, max_photos, lat, lng, radius = 5, license = nil)
      api_key = Rails.application.secrets.flickr_api_key
      # secret = 'dae79e503dedacaa'
      timestamp = '1451606400' # Only grab photos from 2016 - needed for geo queries
      method_name = 'flickr.photos.search'
      request_format = 'json'

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
      url = "https://api.flickr.com/services/rest/?method=#{method_name}&format=#{request_format}&api_key=#{api_key}&media=photos&has_geo=1&min_taken_date=#{timestamp}&content_type=1&lat=#{lat}&lon=#{lng}&radius=#{radius}&extras=#{size_url},geo,owner_name&per_page=#{max_photos}&nojsoncallback=1&safe_search=1"
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
