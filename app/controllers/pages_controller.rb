class PagesController < ApplicationController

  def test_1
  end
  def test_2
  end
  def flickr_time
    gon.dates = FlickrPhoto.all.limit(10).pluck(:date_taken)
    # formatted = []
    # dates.each do |d|
    #   puts "Old Date: #{d}"
    #   new_date = d.strftime('1/1/2016 %H:%M')
    #   formatted <<
    # end
  end
end
