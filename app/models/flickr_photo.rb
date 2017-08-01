class FlickrPhoto < ApplicationRecord
  validates :photo_id, uniqueness: { scope: :city_name }

  def self.pull_photos
    include FlickrHelper
    city_name = 'Santiago'
    puts "Starting pull for #{city_name}"

    # iterating through months
    (1..12).each do |m|
      results = FlickrAPI.get_photos('medium', -33.4456328, -70.6157308, 1, 25, m)
      total_pages = results.dig('photos', 'pages')
      puts "Current page #{results.dig('photos', 'page')} of #{total_pages}"

      # Iterating through pages in results
      (1..total_pages).each do |page|
        results = FlickrAPI.get_photos('medium', -33.4456328, -70.6157308, page, 25, m) #lat/lng is santiago
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
              date_uploaded: p['dateupload']
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
end
