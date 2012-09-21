require 'test/unit'
require 'C:\Users\Osi\RubymineProjects\ese_2012_warmup/app/trade/item'
require 'C:\Users\Osi\RubymineProjects\ese_2012_warmup/app/trade/user'

class TradeTest < Test::Unit::TestCase

  def test_name_of_user
    user = Trade::User.named('John')
    assert( user.name == 'John', 'User has incorrect name')
  end

  def test_amount
    user = Trade::User.named('John')
    assert(user.credits == 100, 'User hasnt got the right amount of credits')
  end

  def test_name_of_item
    user = Trade::User.named('John')
    item = Trade::Item.named('computer', 20, user)
    assert(item.name == 'computer', 'the name of the item is not correct')
  end

  def test_price_of_item
    user = Trade::User.named('John')
    item = Trade::Item.named('computer', 20, user)
    assert(item.price == 20, 'the price of the item is not correct')
  end

  def test_inactive_status_of_item
    user = Trade::User.named('John')
    item = Trade::Item.named('computer', 20, user)
    assert(item.active == false, 'incorrect status')
  end

  def test_active_status_of_item
    user = Trade::User.named('John')
    item = Trade::Item.named('computer', 20, user)
    item.activate
    assert(item.active == true, 'activation did not work')
  end

  def test_owner_of_item
    user = Trade::User.named('John')
    item = Trade::Item.named('computer', 20, user)
    assert(item.owner == user, 'item has not the correct owner')
  end

  def test_adding_new_item
    user = Trade::User.named('John')
    userItem = user.create_item('computer', 20)
    user.add(userItem)
    assert(user.items.all? {|item| item == userItem }, 'adding did not work')
    assert(userItem.active == false, 'wrong status of new item' )
  end

  def test_list_all_items
    user = Trade::User.named('John')
    firstItem = user.create_item('computer', 20)
    secondItem = user.create_item('laptop', 15)
    user.add(firstItem)
    user.add(secondItem)
    assert(user.list_of_all_items == '[computer for 20$, laptop for 15$]')
  end

  def test_list_all_active_items
    user = Trade::User.named('John')
    firstItem = user.create_item('computer', 20)
    secondItem = user.create_item('laptop', 15)
    user.add(firstItem)
    user.add(secondItem)
    secondItem.activate
    assert(user.list_of_active_items == '[laptop for 15$]')
  end

  def test_trade
    john = Trade::User.named('John')
    jack = Trade::User.named('Jack')
    computer = john.create_item('computer', 20)
    laptop = john.create_item('laptop', 15)
    iphone = jack.create_item('iphone', 10)
    john.add(computer)
    john.add(laptop)
    jack.add(iphone)
    john.activate(computer)
    jack.buy(computer)
    assert(jack.items.any? {|x| x == computer}, 'buyer has not got the item')
    assert(jack.credits == 80, 'buyer did not pay the right amount')
    assert(john.items.all? {|x| x != computer}, 'seller still possess the item')
    assert(john.credits == 120, 'seller did not get enough money')
    john.buy(computer)
    assert(john.items.all? {|x| x != computer}, 'immediately after the trade, the item should be inactive')
    john.buy(iphone)
    assert(john.items.all? {|x| x != iphone}, 'item not active, but buyer got it')
  end

end