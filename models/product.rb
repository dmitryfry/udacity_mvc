require 'httparty'
require 'json'

# class product
class Product
  # read access for the Product attributes
  attr_reader :id, :title, :location, :summary, :url, :price

  # ping the API for the product JSON
  url = 'https://fomotograph-api.udacity.com/products.json'
  DATA = HTTParty.get(url)['photos']

  # locations offered by Fomotograph
  LOCATIONS = %w[canada england france ireland mexico scotland taiwan us].freeze

  # initialize a Product object using a data hash
  def initialize(product_data = {})
    @id = product_data['id']
    @title = product_data['title']
    @location = product_data['location']
    @summary = product_data['summary']
    @url = product_data['url']
    @price = product_data['price']
  end

  # return an array of sample products from each location
  def self.sample_locations
    @products = []
    LOCATIONS.each do |location|
      @products.push all.select { |product|
        product.location == location
      }.sample
    end
    @products
  end

  # accepts a location string as an argument and
  # returns an array of Products that have the given location
  def self.find_by_location(location)
    all.select { |product| product.location == location }
  end

  def self.under(limit)
    all.select { |product| product.price < limit }
  end

  def self.find(id)
    all.select { |product| product.id == id.to_i }.first
  end

  # return an array of Product objects
  def self.all
    DATA.map { |product| new(product) }
  end
end
