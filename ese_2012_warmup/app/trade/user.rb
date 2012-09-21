module Trade

  class User

    attr_accessor :name, :credits, :items

    def self.named( name )
      student = self.new
      student.name = name
      student
    end

    def initialize
      self.credits = 100
      self.items = Array.new
    end

    def create_item(name, price)
      item = Trade::Item.named( name , price , self )
      item
    end

    def add(item)
      items.push(item)
    end

    def activate(item)
      if items.any? {|x| x == item}
        item.activate
      end
    end

    def deactivate(item)
      if items.any? {|x| x == item}
        item.deactivate
      end
    end

    def buy(item)
      if item.active == true && self.credits >= item.price && item.owner != self
        seller = item.owner
        seller.sell(item)
        item.owner = self
        self.credits -= item.price
        self.add(item)
        self.deactivate(item)
      end
    end

    def sell(item)
      self.credits += item.price
      items.delete_if {|x| x == item}
    end

    def list_of_active_items
      activeItems = items.clone
      activeItems.delete_if {|x| x.active == false}
      "#{activeItems}"
    end

    def list_of_all_items
      "#{items}"
    end

  end

end