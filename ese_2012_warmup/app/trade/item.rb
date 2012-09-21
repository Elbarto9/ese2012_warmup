module Trade

  class Item

    attr_accessor :name, :price, :active, :owner

    def self.named( name, price, owner)
      item = self.new
      item.name = name
      item.price = price
      item.owner = owner
      item
    end

    def initialize
      self.active = false
    end

    def activate
      self.active = true
    end

    def deactivate
      self.active = false
    end

    def to_s
      "#{name} for #{price}$"
    end

  end
end