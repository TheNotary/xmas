require 'fileutils'

Dir.glob(File.join('.', '* (1)')).each do |duplicate_folder|
  # Check if it's actually a directory
  next unless File.directory?(duplicate_folder)

  # Original folder name (without ' (1)')
  original_folder = duplicate_folder.sub(/ \(1\)$/, '')

  # Check if the original folder exists
  if File.directory?(original_folder)
    # Move all .txt files from original to duplicate folder
    Dir.glob(File.join(original_folder, '*.txt')).each do |file|
      FileUtils.mv(file, duplicate_folder)
    end

    # Remove the original folder if it is empty
    if Dir.empty?(original_folder)
      FileUtils.rmdir(original_folder)
    else
      puts "WARNING: Folder was not empty #{original_folder} not deleting"
    end

    # Rename the duplicate folder
    FileUtils.mv(duplicate_folder, original_folder)
  end
end

