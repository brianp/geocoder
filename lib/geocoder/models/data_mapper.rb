require 'geocoder/models/base'

module DataMapper
  class Property
    class Distance < ::DataMapper::Property::Float
      def dump(value)
        nil
      end
    end # class URI
  end # class Property
end # module DataMapper

module Geocoder
  module Model
    module DataMapper
      include Base

      def self.included(base)
        base.extend(self)
        base.property :distance, ::DataMapper::Property::Distance
      end

      ##
      # Set attribute names and include the Geocoder module.
      #
      def geocoded_by(address_attr, options = {}, &block)
        geocoder_init(
          :geocode       => true,
          :user_address  => address_attr,
          :latitude      => options[:latitude]  || :latitude,
          :longitude     => options[:longitude] || :longitude,
          :geocode_block => block,
          :units         => options[:units],
          :method        => options[:method]
        )
      end

      ##
      # Set attribute names and include the Geocoder module.
      #
      def reverse_geocoded_by(latitude_attr, longitude_attr, options = {}, &block)
        geocoder_init(
          :reverse_geocode => true,
          :fetched_address => options[:address] || :address,
          :latitude        => latitude_attr,
          :longitude       => longitude_attr,
          :reverse_block   => block,
          :units         => options[:units],
          :method        => options[:method]
        )
      end


      private # --------------------------------------------------------------

      def geocoder_file_name;   "data_mapper"; end
      def geocoder_module_name; "DataMapper"; end
    end
  end
end

