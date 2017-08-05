class FlickrPhoto < ApplicationRecord
  validates :photo_id, uniqueness: { scope: :city_name }

  def self.pull_photos
    include FlickrHelper
    city_name = 'Cape Town'
    puts "Starting pull for #{city_name}"

    # iterating through months
    (1..12).each do |m|
      results = FlickrAPI.get_photos('medium', -33.9855835, 18.4224594, 1, 25, m)
      total_pages = results.dig('photos', 'pages')
      puts "Current page #{results.dig('photos', 'page')} of #{total_pages}"

      # Iterating through pages in results
      (1..[40,total_pages].min).each do |page|
        results = FlickrAPI.get_photos('medium', -33.9855835, 18.4224594, page, 25, m) #lat/lng is santiago
        puts "Current page #{results.dig('photos', 'page')} of #{total_pages}"
        puts "...saving #{results.dig('photos', 'perpage')} photos"
        #puts results['photos']['photo']

        photo_array = results.dig('photos', 'photo')
        puts "Photos: #{photo_array.size}"
        photo_array.each do |p|
          photo = FlickrPhoto.new(photo_id: p['id'],
              city_name: city_name,
              owner_id: p['owner'],
              owner_name: p['ownername'],
              title: p['title'],
              lat: p['latitude'].to_f,
              lng: p['longitude'].to_f,
              accuracy: p['accuracy'],
              place_id: p['place_id'],
              date_taken: p['datetaken'],
              taken_granularity: p['datetakengranularity'],
              date_uploaded: p['dateupload'],
              url_z: p['url_z']
            )
          puts photo.valid?
          if photo.save
            puts "...saved photo on page #{page}. #{p['title']}"
          else
            puts "FAILED! Page #{page}. Errors:"
            puts photo.errors.full_messages
          end
        end
      end
    end
  end

  # returns json with each photo in a given city
  # each item in the array has tempHash city date, lat, and lng
  def self.generate_city_json(city = 'New York')
    require 'json'

    photos = [] # array of hashs
    FlickrPhoto.select(:id, :lat, :lng, :date_taken).where(city_name: city).limit(1000).each do |p|
      photos << {lat: p.lat, lng: p.lng, hour: p.date_taken.hour, minute: p.date_taken.min}
    end

    tempHash = {
        "photos" => photos,
        "count" => FlickrPhoto.where(city_name: city).count
    }
    File.open("public/#{city.parameterize}-photos-hour.json","w") do |f|
      f.write(tempHash.to_json)
    end
  end
end
