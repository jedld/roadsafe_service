require 'driver_api'

namespace :populator do
  desc "Downloads incidents online"
  task :start => :environment do
    # OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
    driver_api = DriverApi.new(endpoint: 'https://roadsafety.io', token: '199cbed6157b31b052298d970888a6feb783053d')
    # driver_api = DriverApi.new(endpoint: 'https://roadsafety.gov.ph', token: '7a78477ca3da560bd363cf6e213e9d4100a35509')

    driver_api.setup_record_types

    # p driver_api.setup_record_types
    # p driver_api.query_schema
    # p driver_api.type_lookup
    driver_api.get_incident(start_date:  "2015-01-01T00:00:00.000Z",  end_date: '2015-01-31T23:59:59.000Z') do |result|
      puts "."
      result.each do |item|
        incident = Incident.find_by_external_uuid item['uuid']
        next if incident

        data = item['data']
        Incident.create!(
          description: data['incidentDetails']['Description'],
          lng: item['geom']['coordinates'][0],
          lat: item['geom']['coordinates'][1],
          external_uuid: item['uuid'],
          weather: item['weather'],
          light: item['light'],
          severity: data['incidentDetails']['Severity'],
          occurred_from: item['occurred_from'],
          occurred_to: item['occurred_to'],
          hour_of_day: DateTime.parse(item['occurred_from']).hour,
          day: DateTime.parse(item['occurred_from']).strftime('%Y%m%d'),
        )
      end
    end


  end
end
