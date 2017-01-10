module ShippingScale
  class Package
    def initialize(**options)
      @weight = options[:weight]
      @pounds = options[:pounds]
      @ounces = options[:ounces]
      @length = options[:length]
      @width = options[:width]
      @height = options[:height]
      @zip_origin = (options[:zip_origin]) ? options[:zip_origin] : ShippingScale.config.zip_origin 
      @zip_destination = (options[:zip_destination]) ? options[:zip_destination] : ShippingScale.config.zip_destination

      @attrs = options
    end
    
    def build_xml(package) 
      package.tag!("Service", "All")
      package.tag!("Container", "VARAIBLE")
      package.tag!("Size", "REGULAR")
      @attrs.each { |k, v| package.tag!(k.to_s, v) }
    end

    def get_price!(options = {})
      ShippingScale::Request.config(options)
      ShippingScale::Request.new(packages: [self]).send!     
    end

    #TODO set methods to determin service, container, and size
  end
end