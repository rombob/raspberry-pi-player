#!/usr/bin/ruby

folder_path = '/home/pi/Music/Radio'
renamed_folder = '/home/pi/Music/RadioCleaned'
Dir.glob(folder_path + "/*.mp3").sort.each do |f|
  fn = File.basename f
  puts "from: " + fn
  new_fn = fn.split(' - ')[1..-1].join(' - ')
  puts "to: " + new_fn
  File.rename(f, renamed_folder + "/" + new_fn)
  puts ""
end