class Content < ActiveRecord::Base
    require 'nokogiri'
	require 'open-uri'

	belongs_to :link

	def self.save_content(link)
		link = Link.create(:url => link)
		doc = Nokogiri::HTML(open(link.url))
		links = doc.xpath('//@href').map(&:value).join(" ")
		h1 = doc.css('h1').map(&:text).join(" ")
		h2 =doc.css('h2').map(&:text).join(" ")
		h3 =doc.css('h3').map(&:text).join(" ")
		content = link.build_content
		 content.tags['h1'] = h1
		 content.tags['h2'] = h2
		 content.tags['h3'] = h3
		 content.tags['links'] = links
		content.save
	end
end
