class Video < ActiveRecord::Base

  def self.video_all
    require 'rubygems'
    require 'open-uri'
    require 'nokogiri'
    a_link= 'http://www.iqiyi.com/dianying/'
    page = Nokogiri::HTML(open(a_link))
    a = page.css('.site-piclist_pic_link')
    (0..a.count-1).each do |i|
      next if Video.find_by(url: a[i]['href'])
    Video.create(name: a[i]['title'], url: a[i]['href'])
    end
    # pic = pic = page.css('img')
    # (0..pic.count-1).each do |i|
    #   next if Video.find_by(url: pic[i]['src'])
    # one_video.update(:pic_url =>  pic[i]['src'])
    # end

    #vide = Video.find_by_or_create(title: )
    #puts page.css('.site-piclist_pic_link')[0]['title']
    #puts page.css('.site-piclist_pic_link')[0]['href']
  end
end
