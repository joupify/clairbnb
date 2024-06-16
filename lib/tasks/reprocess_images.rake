namespace :photos do
    desc "Reprocess all photo versions"
    task reprocess: :environment do
      Photo.find_each do |photo|
        photo.image.recreate_versions!
        puts "Reprocessed photo ID: #{photo.id}"
      end
      puts "Reprocessing complete!"
    end
  end
  