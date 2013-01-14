class MediumImport 
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attr_accessor :file

  def initialize(attributes = {})
    attributes.each { |name, value| send("#{name}=", value) }
  end

  def persisted?
    false
  end

  def save
    if imported_media.map(&:valid?).all?
      imported_media.each(&:save!)
      true
    else
      imported_media.each_with_index do |medium, index|
        medium.errors.full_messages.each do |message|
          errors.add :base, "Row #{index+2}: #{message}"
        end
      end
      false
    end
  end

  def imported_media
    @imported_media ||= load_imported_media
    @imported_media
  end

  def load_imported_media
    rows = Array.new
    CSV.foreach(file.path, headers: true) do |row|
      medium = Medium.find_by_id(row["id"]) || Medium.new
      medium.attributes = row.to_hash.slice(*Medium.accessible_attributes)
      rows.push(medium)
      medium
    end
    rows
  end

end
