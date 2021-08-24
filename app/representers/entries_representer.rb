class EntriesRepresenter
  def initialize(entries)
    @entries = entries
  end

  def as_json
    @entries.map do |entry|
      {
        title: entry.entry_type,
        start: entry.started_at.iso8601,
        start: entry.finished_at.iso8601,
        fullDay: false,
      }
    end
  end
end
