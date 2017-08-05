namespace :viz do
  # Gets top-level info for flickr photos
  task extract_manhattan_geojson: :environment do

    #read in json of buroughs
    require 'json'
    file = File.read('public/nyc/nyc-boroughs.geojson')
    data_hash = JSON.parse(file)
    manhattan = nil
    data_hash['features'].each do |f|
      if f['properties']['borough'] == 'Manhattan'
        manhattan = f
        break
      end
    end

    File.open("public/manhattan-outline.geojson","w") do |f|
      f.write(manhattan.to_json)
    end
  end
end
