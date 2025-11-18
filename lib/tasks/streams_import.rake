namespace :streams do
  desc "Import streams data from db/streams_data.json"
  task import: :environment do
    file = Rails.root.join("db", "streams_data.json")

    unless File.exist?(file)
      abort "streams:import failed: file not found at #{file}"
    end

    raw = File.read(file)
    data = JSON.parse(raw)

    Rails.logger.info("[streams:import] Starting import from #{file}")
    Streams::Importer.new(data: data).call
    Rails.logger.info("[streams:import] Import finished successfully")

    puts "Streams data imported successfully."
  rescue Streams::Importer::Error => e
    Rails.logger.error("[streams:import] Importer error: #{e.message}")
    abort "streams:import failed: #{e.message}"
  rescue JSON::ParserError => e
    Rails.logger.error("[streams:import] Invalid JSON: #{e.message}")
    abort "streams:import failed: invalid JSON"
  end
end
