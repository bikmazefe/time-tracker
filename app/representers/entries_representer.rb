# frozen_string_literal: true

class EntriesRepresenter
  def initialize(entries)
    @entries = entries
  end

  def as_json
    @entries.map do |entry|
      {
        title: entry.entry_type,
        start: date_to_iso(entry.started_at),
        end: date_to_iso(entry.finished_at),
      }
    end
  end

  private

  def date_to_iso(date)
    date.iso8601
  end
end
