class PagesController < ApplicationController

  def test_1
  end
  def test_2
  end

  def joymap
  end

  def flickr_hour
    photos = FlickrPhoto.where(city_name: 'New York').select(:date_taken).group_by {|p| p.date_taken.hour}
    gon.frequency_map = {
      0 => photos[0].size,
      1 => photos[1].size,
      2 => photos[2].size,
      3 => photos[3].size,
      4 => photos[4].size,
      5 => photos[5].size,
      6 => photos[6].size,
      7 => photos[7].size,
      8 => photos[8].size,
      9 => photos[9].size,
      10 => photos[10].size,
      11 => photos[11].size,
      12 => photos[12].size,
      13 => photos[13].size,
      14 => photos[14].size,
      15 => photos[15].size,
      16 => photos[16].size,
      17 => photos[17].size,
      18 => photos[18].size,
      19 => photos[19].size,
      20 => photos[20].size,
      21 => photos[21].size,
      22 => photos[22].size,
      23 => photos[23].size
    }
  end
  def flickr_month
    photos = FlickrPhoto.where(city_name: 'Santiago').select(:date_taken).group_by {|p| p.date_taken.month}
    gon.frequency_map = {
      1 => photos[1].size,
      2 => photos[2].size,
      3 => photos[3].size,
      4 => photos[4].size,
      5 => photos[5].size,
      6 => photos[6].size,
      7 => photos[7].size,
      8 => photos[8].size,
      9 => photos[9].size,
      10 => photos[10].size,
      11 => photos[11].size,
      12 => photos[12].size
    }
  end
end
