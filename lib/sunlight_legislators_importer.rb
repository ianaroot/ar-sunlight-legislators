require_relative '../app/models/legislator'
require 'csv'

class SunlightLegislatorsImporter

  IMPLEMENTED = ["title", "firstname", "middlename", "lastname", "party", "state", "in_office",
  "gender", "phone", "fax", "website", "webform", "twitter_id", "birthdate"]

  def self.import
    csv = CSV.new(File.open('./db/data/legislators.csv'), :headers => true)
    csv.each do |row|
      attributes = {}
      row.each do |field, value|
        # TODO: begin
        if !IMPLEMENTED.include?(field)
          begin
            raise NotImplementedError < StandardError
              puts "TODO: figure out what to do with this row and do it!"
            rescue
          end
        elsif value == ""
           attributes[field.to_sym] = nil
        else
          attributes[field.to_sym] = value
        end
      end
      Legislator.create!(attributes)

    end
  end
end


# IF YOU WANT TO HAVE THIS FILE RUN ON ITS OWN AND NOT BE IN THE RAKEFILE, UNCOMMENT THE BELOW
# AND RUN THIS FILE FROM THE COMMAND LINE WITH THE PROPER ARGUMENT.
# begin
#   raise ArgumentError, "you must supply a filename argument" unless ARGV.length == 1
#   SunlightLegislatorsImporter.import(ARGV[0])
# rescue ArgumentError => e
#   $stderr.puts "Usage: ruby sunlight_legislators_importer.rb <filename>"
# rescue NotImplementedError => e
#   $stderr.puts "You shouldn't be running this until you've modified it with your implementation!"
# end
