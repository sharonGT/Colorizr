class String
attr_reader :color_codes

  @@color_codes = {
        :red     => 91,
        :green   => 92, 
        :yellow  => 93,
        :blue    => 34, 
        :pink    => 95,
        :light_blue => 96,
        :white   => 97, 
        :light_grey => 37,
        :black     => 30
      }

#print sample output demostrating all the colors
  def self.sample_colors
    @@color_codes.each do |color, _|
    puts "This is " + "#{color}".send(color) + "."
    end
  end

#method to return an array of all color options
  def self.colors
    @@color_codes.keys
  end

#code to help generate all color methods
  def self.create_colors
    @@color_codes.each do |key, value|
        color_method = %Q{
          def #{key}
            "\e[#{value}m\#{self}\e[0m"
          end
          }
        class_eval(color_method)
    end
  end

#method to return string in color
  def method_missing(method_name, *arguments, &block)
      if @@color_codes.keys.include? method_name.to_sym
        self.class.create_colors
        self.send(method_name.to_s)
      else
        super
      end
    end
end


