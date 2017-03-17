class QueryController < ApplicationController
  def index
    radius = params[:radius] || 1
    incidents = Incident.within(radius, :origin => [params[:lat], params[:lng]])

    if params[:hour]
      incidents = incidents.where(hour_of_day: params[:hour].to_s)
    end

    render json: { count: incidents.size, result: incidents.collect(&:to_json) }
  end

  def stats
    radius = params[:radius] || 1
    incidents = Incident.within(radius, :origin => [params[:lat], params[:lng]])

    if params[:hour]
      incidents =incidents.where(hour_of_day: params[:hour].to_s)
    end

    fatal_count = incidents.where(severity: 'Fatal').count || 0
    injury_count = incidents.where(severity: 'Injury').count || 0
    property_count = incidents.where(severity: 'Property').count || 0

    days = incidents.distinct.pluck(:day).count.to_f
    render json: {
        fatal_risk_factor: days > 0 ? fatal_count.to_f / days : 0,
        injury_risk_factor: days > 0 ? injury_count.to_f / days : 0,
        property_risk_factor: days > 0 ? property_count.to_f / days : 0,
        total: incidents.size,
        fatal: fatal_count,
        injury: injury_count,
        property: property_count
      }
  end
end
