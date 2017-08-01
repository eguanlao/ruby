#!/usr/bin/env ruby

require 'csv'

class MemberFinder
	attr_accessor :all_applications_file_path, :all_logged_in_file_path

	def initialize(all_applications_file_path, all_logged_in_file_path)
		@all_applications_file_path = all_applications_file_path
		@all_logged_in_file_path = all_logged_in_file_path
  		puts "Input: #{@all_applications_file_path}, #{@all_logged_in_file_path}"
	end

	def getMembers()
		members = Hash.new

		# Loading app applications into memory
		CSV.foreach(@all_applications_file_path) do |val|
			members[val[0]] = "1"
		end

		# Parsing second file and looking for members that dont exist in the collection above
		lostMembers = Array.new
		CSV.foreach(@all_logged_in_file_path) do |val|
			if members.has_key?(val[0])
				lostMembers.push(val[0])
			end
        end

		puts "#{lostMembers.count}\n"
		puts "#{lostMembers}\n"

	end
end

if __FILE__ == $0
	finder = MemberFinder.new(ARGV[0], ARGV[1])
	finder.getMembers()
end
