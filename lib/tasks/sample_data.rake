namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    make_users
    make_miniposts
    make_responses
    make_followerships
    make_interests
    make_votes
  end
end

@topics = %w[software tools web ubuntu tv web school course design code algo]

def make_users
  ['University of Washington', 'University of Texas', 'Seattle University'].each do |n|
    Affiliation.create!(:name => n)
  end

  User.create!(:name => "Example User",
               :email => "example@example.com",
               :password => "foobar",
               :password_confirmation => "foobar",
               :affiliation_id => 1)

  99.times do |n|
    name = Faker::Name.name
    email = "example-#{n+1}@example.com"
    password = "foobar"
    User.create!(:name => name,
                 :email => email,
                 :password => password,
                 :password_confirmation => password,
                 :affiliation_id => 1)
  end
end

def make_miniposts
  50.times do
    User.all(:limit => 6).each do |user|
      m = user.miniposts.build(:content => Faker::Lorem.sentence(5))
      m.affiliation_id = user.affiliation_id
      ts = @topics.shuffle[0..4]
      ts.each do |t|
        t.downcase!
        tp = Topic.find_by_name(t) || Topic.create(:name => t)
        m.topics << tp unless m.topics.include?(tp)
      end
      m.save
    end
  end
end

def make_responses
  users = User.all(:limit => 6)
  users.each do |user|
    user.miniposts(:limit => 5).each do |post|
      users.reverse.each do |res_user|
        res = res_user.responses.create!(:content => Faker::Lorem.sentence(5))
        post.responses << res
      end
    end
  end
end

def make_followerships
  User.all(:limit => 6).each do |user|
    ts = @topics.shuffle[0..4]
    ts.each do |t|
      t.downcase!
      tp = Topic.find_by_name(t)
      user.follow!(tp) unless tp.nil? or user.following?(tp)
    end
  end
end

def make_interests
  users = User.all(:limit => 6)
  users.each do |user|
    user.miniposts(:limit => 5).each do |post|
      users.reverse[0..4].each do |res_user|
        res_user.followpost!(post) unless res_user.followingpost?(post)
      end
    end
  end
end

def make_votes
  users = User.all(:limit => 6)
  users.each do |user|
    user.miniposts(:limit => 5).each do |post|
      post.responses(:limit => 4).each do |res|
        users.reverse[0..4].each do |r_user|
          r_user.voteresponse!(res) unless r_user.votedresponse?(res)
        end
      end
    end
  end
end
