# By using the symbol ':user', we get Factory Girl to simulate the User model.
Factory.define :affiliation do |affiliation|
  affiliation.name "University of Texas"
end

Factory.define :user do |user|
  user.name "Vinay Vyas"
  user.email "vinay@example.com"
  user.password "foobar"
  user.password_confirmation "foobar"
  user.association :affiliation
end

Factory.sequence :name do |n|
  "Person #{n}"
end

Factory.sequence :email do |n|
  "person-#{n}@example.com"
end

Factory.define :minipost do |minipost|
  minipost.content "Foo bar"
  minipost.association :user
  minipost.association :affiliation
end

Factory.define :response do |response|
  response.content "Baz qux"
  response.association :user
end
