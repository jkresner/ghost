# id
# user
# name
# img
# created_at

Avatars = new Meteor.Collection 'avatars'

Avatars.allow
  insert: (userId, avatar) -> false
  update: (userId, avatars, fields, mods) ->
    _.all avatars, (a) ->
      if a.userId? then return false # Already owned
      allowed = ["userId"]
      if _.difference(fields, allowed).length then return false # tried to write to forbidden field
      true
  remove: (userId, avatar) ->
    Meteor.users.findOne({id: userId}).admin ? true : false

# commented out because it was taking the app 20 seconds to reload on each change
# fs = __meteor_bootstrap__.require 'fs'
# Meteor.avatarImages =
#  _.map _.reject(fs.readdirSync('public/images/avatars'), (file) -> file == '.DS_Store'), (file) ->
#      '/images/avatars/' + file

Meteor.methods
  createAvatar: (data) ->
    console.log('MAKE AVATAR')
    data.createdAt = (new Date).getTime()
    id = Avatars.insert data
    data._id = id
    console.log(data)
    data
  fetchAvatar: (userId) ->
    Avatars.findOne({userId: userId}, {sort:{createdAt: -1}})
  updateAvatar: (id, data) ->
    Avatars.update({_id: id}, {$set: data})
    console.log(data)
    data

avatars = []
for i in [1..25]
  avatars.push "av#{i}.png"

avatarFirstNames = [
  'Mad', 'Maddest', 'Fat', 'Fattest', 'Dumb', 'Dumbest', 'Worst', 'Saintly', 'Perverse', 'Wild', 'Wildest', 'Smelly', 'Smelliest', 'Crabby', 'Crabbiest', 'Annoying', 'Simple', 'Sadistic', 'Troubled', 'Ecstatic', 'Janky', 'Loopy',
  'Snarky', 'Healthy', 'Tasty', 'Tricky', 'Ugly', 'Dirty', 'Terrible', 'Fugly', 'Crappy', 'Sweetest', 'Rude', 'Fair', 'Stoopid', 'Fast', 'Gay', 'Not-gay', 'Scrappy', 'Shallow', 'Average', 'Arrogant', 'Ashamed',
  'Dizzy', 'Dull', 'Sarcastic', 'Hungry', 'Moaning', 'Modern', 'Icy', 'Proud', 'Mr.', 'Mrs.', 'Stingy', 'Smal', 'Tall', 'Large', 'Little', 'Big', 'Frantic', 'Petite', 'Prickly', 'Jealous', 'Ordinary',
  'Obnoxious', 'Energetic', 'Wicked', 'Wet', 'Witty', 'Biggie', 'Smokey', 'Interesting', 'Funky', 'Savage', 'Jiggly', 'Jumbly', 'Fabulous', 'Shiny', 'Beastly', 'Twinkly', 'Slimy', 'Cacophonous', 'Gooey', 'Stinky', 'Zippy',
  'Snobby', 'Skinny', 'Rotten', 'Legendary', 'Awkward', 'Convivial', 'Furry', 'Naked', 'Buxom', 'Lumpy', 'Diseased', 'Gorgeous', 'Campy', 'Magical', 'Deadly', 'Horny', 'Randy', 'Electric', 'Poison', 'Delicious', 'Bloody',
  'Nervous', 'Hillbilly', 'Boneless', 'Trashy', 'Notorious', 'Salty', 'Nutritious', 'Wet', 'Moist', 'Damp', 'Dry', 'Freckled', 'Bearded', 'Fiery', 'Melted', 'Saggy', 'Fleshy', 'Sour', 'Acid', 'Genius', 'Dark',
  'Creepy', 'Misty', 'Foggy', 'Blurry', 'Glorious', 'Cheesy', 'Digital', 'Pixelated', 'Shadowy', 'Wobbly', 'Floppy', 'Unstable', 'Gregarious', 'Duplicitous', 'Pale', 'Sloppy', 'Saucy', 'Needy', 'Wrinkly', 'Cold-blooded', 'Denim',
  'Dainty', 'Sneaky', 'Giant', 'Sexy', 'Lord', 'Dame', 'Greasy'
]

avatarLastNames = [
  'Cat', 'Hippopotamus', 'Sloth', 'Mormon', 'Child', 'Atheist', 'Pope', 'Whore', 'Platypus', 'Iguana', 'Walrus', 'Dolphin', 'Blunderbuss', 'Fritatta', 'Flapjack', 'Dumbo', 'Meanie', 'Crab', 'Dungeon', 'Temple', 'Ninja',
  'Wombat', 'Pirate', 'Motel', 'Buccaneer', 'Didgeridoo', 'Girdle', 'Manscape', 'Weasel', 'Chimpanzee', 'Poltergeist', 'Boar', 'Pilot', 'Taco', 'Burrito', 'Flauta', 'Hamburger', 'Cheeseburger', 'Pancake', 'Kangaroo', 'Dog', 'Feline',
  'Troll', 'Hacker', 'Taint', 'Manchild', 'Elephant', 'Asshat', 'Ass', 'Donkey', 'Horse', 'Cow', 'Duck', 'Pig', 'Giraffe', 'Lion', 'Book', 'Phone', 'Desk', 'Dentist', 'Doctor', 'Comedian', 'CEO',
  'Startup', 'Bus', 'Car', 'Spork', 'T-Rex', 'Dino', 'President', 'Lop', 'Mop', 'Flipflop', 'Booger', 'Name', 'Dingo', 'Toe Jam', 'Wafer', 'Sasquatch', 'Lampshade', 'Monster', 'Wolfboy', 'Raccoon', 'Oatmeal',
  'Muffin', 'Hoarder', 'Hipster', 'Melon', 'Goat', 'Sweatervest', 'Horsemeat', 'Centaur', 'Meatloaf', 'Lasagna', 'Magician', 'Samurai', 'Lemur', 'Empanada', 'Goatboy', 'Cat Lady', 'Armpit', 'Delivery', 'Pill', 'Handbag', 'Mitten',
  'Pimp Cup', 'Redneck', 'Engrish', 'Cabbie', 'Sushi', 'Celebutante', 'Love Letter', 'Nymph', 'Bieber', 'Mullett', 'Futon', 'Mustache', 'Accordion', 'Planet', 'Bean Dip', 'Bath Robe', 'Kibble', 'Villain', 'Superhero', 'Candy', 'Dreams',
  'Tugboat', 'Salami', 'Babysitter', 'Science', 'Potato', 'Truck Stop', 'Cheese Puff', 'Phone Booth', 'Gnome', 'G-string', 'Waffle', 'Bacon', 'Headcheese', 'Toothpaste', 'Pharmacist', 'Burger', 'Door Knob', 'Infomercial', 'Serpent', 'Woodpecker', 'Zeppelin',
  'Tumor', 'Grapefruit', 'Thimble', 'Vitamin', 'Cuticle', 'Pretzel', 'Pizza Juice', 'Handkercheif'
]

setSessionAvatar = ->
  avatar = Session.get 'avatar'
  user = Meteor.user()

  if ! avatar? && user?
    mostrecent_avatar = Meteor.call 'findAvatar', user._id
    if ! avatarExpired mostrecent_avatar
      avatar = mostrecent_avatar

  if !avatar? || ! avatarExpired avatar
    avatar = generateAvatar user

  avatar

avatarExpired = (avatar) ->
  return true if ! avatar?
  avatar.createdAt < ((new Date()).getTime() - 24 * 60 * 60 *1000)

generateAvatar = (user) ->

  avatar =
    createdAt: (new Date()).getTime()
    img: Random.choice avatars # TODO: FIX THIS Session.get('avatar_images')
    name: Random.choice(avatarFirstNames) + Random.choice(avatarLastNames)
    userId: user._id if user?

  retAvatar = Meteor.call 'createAvatar', avatar, (err, d) ->
    Session.set 'avatar', d

  Meteor.call 'createAvatar', avatar, (err, d) ->
    avatar._id = d
    Session.set 'avatar', avatar

  avatar
