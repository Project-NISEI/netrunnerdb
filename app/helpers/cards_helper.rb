module CardsHelper
  def load_edn_from_dir(path)
    cards = []
    Dir.glob(path) do |f|
      next if File.directory? f

      File.open(f) do |file|
        cards << EDN.read(file)
      end
    end
    cards
  end

  def convert_symbol(type)
    return if type.nil?

    type.to_s.underscore
  end

  def convert_subtype(subtypes)
    return if subtypes.nil?

    subtypes.map(&:to_s).map(&:upcase_first).join(' - ')
  end

  def import_sides(path)
    path += 'sides.edn'
    sides = nil
    File.open(path) do |file|
      sides = EDN.read(file)
    end
    sides
      .map! do |side|
      {
        code: convert_symbol(side[:id]),
        name: side[:name],
      }
    end
    Side.import sides, on_duplicate_key_update: { conflict_target: [ :code ], columns: :all }
  end

  def import_factions(path)
    path += 'factions.edn'
    factions = nil
    File.open(path) do |file|
      factions = EDN.read(file)
    end
    factions
      .map! do |faction|
      {
        code: convert_symbol(faction[:id]),
        is_mini: faction[:"is-mini"],
        name: faction[:name],
      }
    end
    Faction.import factions, on_duplicate_key_update: { conflict_target: [ :code ], columns: :all }
  end

  def import_types(path)
    path += 'types.edn'
    types = nil
    File.open(path) do |file|
      types = EDN.read(file)
    end
    types
      .map! do |type|
      {
        code: convert_symbol(type[:id]),
        name: type[:name],
      }
    end
    CardType.import types, on_duplicate_key_update: { conflict_target: [ :code ], columns: :all }
  end

  def import_subtypes(path)
    path += 'subtypes.edn'
    subtypes = nil
    File.open(path) do |file|
      subtypes = EDN.read(file)
    end
    subtypes
      .map! do |subtype|
      {
        code: convert_symbol(subtype[:id]),
        name: subtype[:name],
      }
    end
    Subtype.import subtypes, on_duplicate_key_update: { conflict_target: [ :code ], columns: :all }
  end

  def import_cards(path: '../netrunner-data/edn/')
    cards = load_edn_from_dir(path + 'cards/*.edn')
    factions = Faction.all.index_by(&:code)
    sides = Side.all.index_by(&:code)
    types = CardType.all.index_by(&:code)
    subtypes = Subtype.all.index_by(&:code)

    new_cards = []
    cards.each do |card|
      new_card = Card.new(
        advancement_requirement: card[:"advancement-requirement"],
        agenda_points: card[:"agenda-points"],
        base_link: card[:"base-link"],
        code: card[:id],
        cost: card[:cost],
        deck_limit: card[:"deck-limit"],
        influence_cost: card[:"influence-cost"],
        influence_limit: card[:"influence-limit"],
        memory_cost: card[:"memory-cost"],
        minimum_deck_size: card[:"minimum-deck-size"],
        name: card[:title],
        subtypes: card[:subtype]&.collect { |x| subtypes[convert_symbol(x)].name }&.join(' - '),
        strength: card[:strength],
        text: card[:text],
        trash_cost: card[:"trash-cost"],
        uniqueness: card[:uniqueness]
      )
      new_card.faction = factions[convert_symbol(card[:faction])] if card[:faction]
      new_card.side = sides[convert_symbol(card[:side])] if card[:side]
      new_card.card_type = types[convert_symbol(card[:type])] if card[:type]
      card[:subtype]&.each do |s|
        new_card.subtype_relations << subtypes[convert_symbol(s)]
      end
      new_cards << new_card
    end

    new_cards.each_slice(100) { |s|
      Card.import s, on_duplicate_key_update: { conflict_target: [ :code ], columns: :all }
    }
  end

  def select_cycle_code(code)
    codes = {
      'revised-core': 'core2',
      'napd-multiplayer': 'napd',
      'system-core-2019': 'sc19',
    }
    codes[code] || code
  end

  def import_cycles(path)
    path += 'cycles.edn'
    cycles = nil
    File.open(path) do |file|
      cycles = EDN.read(file)
    end
    cycles
      .map! do |cy|
      {
        code: select_cycle_code(cy[:id]),
        name: cy[:name],
        description: cy[:description],
      }
    end
    NrCycle.import cycles, on_duplicate_key_update: { conflict_target: [ :code ], columns: :all }
  end

  def import_set_types(path)
    path += 'set-types.edn'
    set_types = nil
    File.open(path) do |file|
      set_types = EDN.read(file)
    end
    set_types
      .map! do |set_type|
      {
        code: convert_symbol(set_type[:id]),
        name: set_type[:name],
      }
    end
    NrSetType.import set_types, on_duplicate_key_update: { conflict_target: [ :code ], columns: :all }
  end

  def import_sets(path)
    nr_cycles = NrCycle.all.index_by(&:code)
    nr_set_types = NrSetType.all.index_by(&:code)

    path += 'sets.edn'
    sets = nil
    File.open(path) do |file|
      sets = EDN.read(file)
    end

    new_sets = []
    sets.each do |set|
      new_sets << NrSet.new(
        code: set[:id],
        name: set[:name],
        date_release: set[:"date-release"] ? Date.parse(set[:"date-release"]) : nil,
        size: set[:size],
        nr_cycle:  nr_cycles[select_cycle_code(set[:"cycle-id"])],
        nr_set_type: set[:"set-type"] ? nr_set_types[convert_symbol(set[:"set-type"])] : nil,
      )
    end
    NrSet.import new_sets, on_duplicate_key_update: { conflict_target: [ :code ], columns: :all }
  end

  def import_printings(path)
    set_cards = load_edn_from_dir(path + 'set-cards/*.edn').flatten
    raw_cards = Card.all.index_by(&:code)
    nr_sets = NrSet.all.index_by(&:code)

    new_printings = []
    set_cards.each do |set_card|
      card = raw_cards[set_card[:"card-id"]]
      nr_set = nr_sets[set_card[:"set-id"]]

      new_printings << Printing.new(
        printed_text: card[:text],
        printed_uniqueness: card[:uniqueness],
        code: set_card[:code],
        flavor: set_card[:flavor],
        illustrator: set_card[:illustrator],
        position: set_card[:position],
        quantity: set_card[:quantity],
        date_release: nr_set[:date_release],
        card: card,
        nr_set: nr_set
      )
    end

    new_printings.each_slice(100) { |s|
      Printing.import s, on_duplicate_key_update: { conflict_target: [ :code ], columns: :all }
    }
  end

  def import_legality_types
    legality_types = []
    legality_types << LegalityType.new(name: 'Legal', code: 'legal')
    legality_types << LegalityType.new(name: 'Not Legal', code: 'not_legal')
    legality_types << LegalityType.new(name: 'Restricted', code: 'restricted')
    legality_types << LegalityType.new(name: 'Banned', code: 'banned')
    LegalityType.import legality_types, on_duplicate_key_update: { conflict_target: [ :code ], columns: :all }
  end

  def import_formats
    deck_formats = []
    deck_formats << DeckFormat.new(name: 'Standard', code: 'standard')
    deck_formats << DeckFormat.new(name: 'Eternal', code: 'eternal')
    deck_formats << DeckFormat.new(name: 'Core Experience', code: 'core_experience')
    deck_formats << DeckFormat.new(name: 'Snapshot', code: 'snapshot')
    deck_formats << DeckFormat.new(name: 'Cache Refresh', code: 'cache_refresh')
    deck_formats << DeckFormat.new(name: 'Classic', code: 'classic')
    DeckFormat.import deck_formats, on_duplicate_key_update: { conflict_target: [ :code ], columns: :all }
  end

  def select_legality_type(type)
    if type == :rotated
      'not_legal'
    else
      type.to_s
    end
  end

  def select_format(format)
    formats = {
      'core-experience': 'core_experience',
      'socr': 'cache_refresh',
    }
    formats[format] || format.to_s
  end

  def import_card_legalities(path)
    path += 'raw_data.edn'
    raw_data = nil
    File.open(path) do |file|
      raw_data = EDN.read(file)
    end

    cards = Card.all.index_by(&:code)
    types = LegalityType.all.index_by(&:code)
    formats = DeckFormat.all.index_by(&:code)

    card_legalities = []
    raw_data[:cards].each do |card|
      card[:format].each do |ff, ll|
        next if ff == :'snapshot-plus'

        card_legalities << Legality.new(
          legality_type: types[select_legality_type(ll)],
          deck_format: formats[select_format(ff)],
          card: cards[card[:normalizedtitle]]
        )
      end
    end

    card_legalities.each_slice(100) {|s|
      Legality.import s, on_duplicate_key_update: { conflict_target: [ :deck_format_id, :card_id], columns: :all }
    }
  end

  def log_import(s)
    puts '[%s] Importing %s...' % [Time.new, s]
  end

  def import
    path = '../netrunner-data/edn/'

    log_import('sides')
    import_sides path

    log_import('factions')
    import_factions path

    log_import('types')
    import_types path

    log_import('subtypes')
    import_subtypes path

    log_import('cards')
    import_cards path: path

    log_import('cycles')
    import_cycles path

    log_import('set types')
    import_set_types path

    log_import('sets')
    import_sets path

    log_import('printings')
    import_printings path

    log_import('legality types')
    import_legality_types

    log_import('formats')
    import_formats

    log_import('card legalities')
    import_card_legalities path

    puts '[%s] Done!' % [Time.new]
  end
end
