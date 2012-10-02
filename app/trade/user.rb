module Trade
  #An user is a very important piece of the trade.
  #He is able to buy and to activate some items,
  #so that they can be sold to another user.

  class User

    attr_accessor :name, :credits, :items

    def self.named( name )
      student = self.new
      student.name = name
      student
    end

    def initialize
      self.credits = 100
      self.items = Array.new # AK prefer the empty array literal `[]`
    end

    #creates an item, with a given name and price.
    # @param [String] name
    # @param [Integer] price
    def create_item(name, price)
      item = Trade::Item.named( name , price , self )
    end

    #adds the created item to the list of items.
    # @param [Item] item
    def add(item)
      items.push(item) # AK you could also use `<<`
    end

    #activated the item, so that it is able to be sold.
    # @param [Item] item
    def activate(item)
      if items.any? {|x| x == item} # AK the method for this is: `items.include? item`
        item.activate               # Yeah, I have to look that up every time I haven't used ruby in a week, the name is not too great.
      end
    end

    #deactivates the item, so that it is disabled.
    # @param [Item] item
    def deactivate(item)
      if items.any? {|x| x == item}
        item.deactivate
      end
    end

    #buys an item, if the buyer isn't the owner of this item yet, has enough money and the
    #item itself had been activated so far. So the buyer pays the price and can add the item to his list
    #of items.
    # @param [Item] item
    def buy(item)
      if item.active == true && self.credits >= item.price && item.owner != self # AK factor this condition into a method, e.g. `can_buy? item`. also you don't need to test equality for bools
        seller = item.owner
        seller.sell(item)
        item.owner = self
        self.credits -= item.price
        self.add(item)
        self.deactivate(item)
      end
    end

    #sells an item, so that the user gets the money and take the
    #item out of his list of items.
    # @param [Item] item
    def sell(item)
      self.credits += item.price
      items.delete_if {|x| x == item} # AK `items.delete(item)`
    end

    # AK these do not return a list, but the names state that!
    def list_of_active_items
      # AK maybe not the best name for a method that returns a string
      active_items = items.clone
      active_items.delete_if {|x| !x.active} # AK active_items = items.select {|i| i.active}
      string = ""
      active_items.each {|x| string += x.to_s + " -- "}
      "#{string}" # "#{active_items.join(' -- ')}"
    end

    def list_of_all_items
      string = ""
      items.each {|x| string += x.to_s + " -- "}
      "#{string}"
    end

  end

end
