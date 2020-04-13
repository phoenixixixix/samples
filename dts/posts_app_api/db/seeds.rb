# frozen_string_literal: true

puts 'Seeding users'

users = [
  User.create!(name: 'John Doe', email: 'john@example.com'),
  User.create!(name: 'Jane Smith', email: 'jane@example.com'),
  User.create!(name: 'Alice Jones', email: 'alice@example.com'),
  User.create!(name: 'Victor Grenkin', email: 'victor@example.com'),
  User.create!(name: 'Sara Jenkins', email: 'sara@example.com')
]


puts 'Seeding posts'

post_texts = [
  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
  'Vitae congue mauris rhoncus aenean vel elit.',
  'Lectus proin nibh nisl condimentum id venenatis a.',
  'Quis risus sed vulputate odio ut enim.',
  'Enim lobortis scelerisque fermentum dui faucibus in ornare.',
  'Volutpat commodo sed egestas egestas fringilla.',
  'Mattis aliquam faucibus purus in.',
  'Id diam vel quam elementum pulvinar.',
  'In egestas erat imperdiet sed euismod nisi porta lorem.',
  'Nibh praesent tristique magna sit amet purus gravida.',
  'Id donec ultrices tincidunt arcu non.',
  'Ac auctor augue mauris augue neque gravida in fermentum et.',
  'Pellentesque pulvinar pellentesque habitant morbi tristique senectus.',
  'Quis viverra nibh cras pulvinar mattis nunc sed.',
  'Cursus eget nunc scelerisque viverra mauris in.',
  'Eget lorem dolor sed viverra ipsum.',
  'Tristique et egestas quis ipsum suspendisse ultrices gravida dictum fusce.',
  'Eget duis at tellus at.',
  'Vivamus arcu felis bibendum ut tristique et egestas quis.',
  'Feugiat nisl pretium fusce id velit ut tortor pretium.',
  'Consequat mauris nunc congue nisi vitae.',
  'Non pulvinar neque laoreet suspendisse interdum consectetur libero.',
  'Sollicitudin tempor id eu nisl nunc mi ipsum faucibus.',
  'Tortor condimentum lacinia quis vel eros donec.',
  'Netus et malesuada fames ac turpis egestas integer eget.',
  'Sem integer vitae justo eget magna fermentum.',
  'Posuere morbi leo urna molestie at.',
  'Nec nam aliquam sem et tortor consequat id porta nibh.',
  'Id donec ultrices tincidunt arcu non.',
  'Mattis molestie a iaculis at erat pellentesque adipiscing commodo.',
  'Dapibus ultrices in iaculis nunc.',
  'Ipsum suspendisse ultrices gravida dictum fusce ut placerat orci.',
  'Lorem ipsum dolor sit amet consectetur adipiscing elit.',
  'Sed faucibus turpis in eu mi bibendum neque egestas.',
  'Augue ut lectus arcu bibendum at varius vel.',
  'Tortor id aliquet lectus proin.',
  'In nulla posuere sollicitudin aliquam ultrices sagittis orci a.',
  'Habitasse platea dictumst vestibulum rhoncus est.',
  'Amet luctus venenatis lectus magna.',
  'Purus viverra accumsan in nisl nisi scelerisque eu ultrices vitae.',
  'Elementum integer enim neque volutpat.',
  'Id eu nisl nunc mi ipsum faucibus vitae aliquet nec.',
  'Adipiscing diam donec adipiscing tristique risus nec.',
  'Et malesuada fames ac turpis.',
  'Vitae suscipit tellus mauris a diam maecenas.'
]

posts = post_texts.map { |text| Post.create!(body: text) }


puts 'Seeding likes'

posts.each do |post|
  likes_count = post.body.length % (users.size + 1)
  users.first(likes_count).each { |user| Like.create!(post: post, user: user) }
end


puts 'Seeding comments'

comment_number = 1
posts.each do |post|
  comments_count = (post.body.length % (users.size + 1)) * 3
  comments_count.times.each do |comment_index|
    user = users[comment_index % users.size]
    Comment.create!(post: post, user: user, body: "Comment ##{comment_number}")
    comment_number += 1
  end
end
