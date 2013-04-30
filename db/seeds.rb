store1 = Store.create(name: "Xmen", path: "xmen", description: "all things xmen", status: "pending")
store2 = Store.create(name: "Avengers", path: "avengers", description: "all things avengers", status: "online")
store3 = Store.create(name: "Justice League", path: "justice-league", description: "all things justice league", status: "online")
store4 = Store.create(name: "Spacely Sprockets", path: "spacely-sprockets", description: "For those who like rusty stuff from junkyards", status: "online")

user1 = User.create(full_name: "Professor X", email: "admin@example.com", password: "password")
user2 = User.create(full_name: "Wolverine", email: "wolverine@example.com", password: "password")
user3 = User.create(full_name: "Ironman", email: "ironmanw@example.com", password: "password")
user4 = User.create(full_name: "Batman", email: "batman@example.com", password: "password")
user5 = User.create(full_name: "Magneto", email: "magneto@example.com", password: "password")
User.create(full_name: "Logan Sears", display_name: "Logan", email: "lsears322@gmail.com", password: "password")

user1.assign_super_admin
user1.super_admin = true
user1.save

UserStoreRole.create({user_id: 2, store_id: 1, role: 'admin'})
UserStoreRole.create({user_id: 3, store_id: 2, role: 'stocker'})
UserStoreRole.create({user_id: 4, store_id: 3, role: 'admin'})

Auction.create(store_id: store4.id, expiration_date: DateTime.new(2013, 5, 2), starting_bid: 0, shipping_options: 'international', active: true)
Auction.create(store_id: store4.id, expiration_date: (Time.now + 86400), starting_bid: 0, shipping_options: 'international', active: true)

Product.create(auction_id: 1, title: 'Rusty Rocket Ship', description: 'This old lady was the prototype for Apollo 11. I stole her from NASA after they threw in a junkyard. I bet this baby is worth millions', active: true)
Product.create(auction_id: 2, title: 'Rusty Bicycle', description: 'My grandaddy rode this bad boy to and from school, uphill both ways, in the snow.', active: true)

PaymentOption.create(auction_id: 1, payment_type: 'credit')
PaymentOption.create(auction_id: 2, payment_type: 'cash')
