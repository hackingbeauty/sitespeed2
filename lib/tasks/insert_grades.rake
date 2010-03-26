# namespace :grades do
#   
#   desc "Insert Yslow! and Page Speed grades"
#   task :insert => [:yslow, :pagespeed]
# 
#   desc "Insert Yslow! grades into db"
#   task :yslow => :environment do
#     print "Inserting Yslow! Grades"
#     puts "\nDone"
#   end
#   
#   desc  'Insert Page Speeds grades into db'
#   task :pagespeed => :environment do
#     print "Inserting Page Speed Grades"
#     puts "\nDone"
#   end
#   
# end
