cards = []
Dir.glob('../netrunner-data/edn/cards/*.edn') do |f|
  next if File.directory? f
  File.open(f) do |file|
    cards << EDN.read(file)
  end
end
merged_card = cards.reduce({}, :merge)
mappings = merged_card.keys.zip(merged_card.stringify_keys.keys.map(&:underscore).map(&:to_sym)).to_h
cards.map! { |h| h.map { |k, v| [mappings[k] || k, if v.is_a? Symbol; v.to_s else v end] }.to_h }
