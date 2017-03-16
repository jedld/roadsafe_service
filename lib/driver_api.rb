require 'httparty'
class DriverApi
  attr_reader :type_lookup

  def initialize(endpoint: 'https://roadsafety.io', token:)
    @endpoint = endpoint
    @token = token
    @type_lookup = {}
  end

  def setup_record_types
    url = "#{@endpoint}/api/recordtypes/?active=True&label=Incident"
    response = HTTParty.get(url,
      headers: {
        "Authorization" => "Token #{@token}",
        })
    result = JSON.parse(response.body)
    result['results'].each do | types |
      @type_lookup[types["label"]] = {
        uuid: types["uuid"]
      }
    end
  end

  def query_schema
    url = "#{@endpoint}/api/recordschemas/#{@type_lookup["Incident"][:uuid]}/"
    response = HTTParty.get(url,
    headers: {
      "Authorization" => "Token #{@token}",
      })
    JSON.parse(response.body)
  end

  def get_incident(start_date:, end_date:, &block)
    url = "#{@endpoint}/api/records"
    response = HTTParty.get(url,
      query: {
        archived: 'False',
        occurred_max: end_date,
        occurred_min: start_date,
        record_type: @type_lookup["Incident"][:uuid],
        jsonb: '{"incidentDetails":{"Severity":{"_rule_type":"containment"}}}'
      },
      headers: {
        "Authorization" => "Token #{@token}",
        })
    response = JSON.parse(response.body)
    while response["next"] do
      block.(response["results"])
      r = HTTParty.get(response["next"], headers: { "Authorization" => "Token #{@token}" })
      response = JSON.parse(r.body);
    end
  end

  private

  def build_jsonb_query

  end
end
