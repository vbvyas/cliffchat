# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Create the initial affiliations for Universities in Washington and British Columbia
['Peninsula College', 'Bellevue College', 'Central Washington University', 'Eastern Washington University',
  'The Evergreen State College', 'University of Washington', 'University of Washington - Bothell',
  'University of Washington - Tacoma', 'Washington State University', 'Washington State University - Spokane',
  'Washington State University - Tri-Cities', 'Washington State University - Vancouver',
  'Western Washington University', 'University of Puget Sound', 'Walla Walla University',
  'Whitman College', 'Whitworth University', 'Antioch University', 'Argosy University',
  'The Art Institute of Seattle', 'Bastyr University', 'City University of Seattle',
  'Cornish College of the Arts', 'Gonzaga University', 'Seattle Pacific University',
  'Seattle University', 'Capilano University', 'Emily Carr University of Art and Design',
  'Fairleigh Dickinson University', 'Kwantlen Polytechnic University', 'Quest University',
  'Royal Roads University', 'Simon Fraser University', 'Thompson Rivers University',
  'Trinity Western University', 'University of British Columbia', 'University of Victoria',
  'University Canada West', 'University of the Fraser Valley', 'University of Northern British Columbia',
  'Vancouver Island University'].each do |u|
    Affiliation.find_or_create_by_name(name: u)
  end
