class Incident < ApplicationRecord
  acts_as_mappable :default_units => :kms

  def to_json
    {
      description: description,
      severity: severity,
      lat: lat,
      lng: lng,
      weather: weather,
      occurred_from: occurred_from,
      occurred_to: occurred_to
    }
  end
end
