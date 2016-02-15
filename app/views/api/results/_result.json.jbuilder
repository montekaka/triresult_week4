json.place result.overall_place
json.time format_hours result.secs
json.last_name result.last_name
json.first_name result.first_name
json.bib result.bib
json.city result.city
json.state result.state
json.gender result.racer.gender
json.gender_place result.gender_place
json.group result.group.name
json.group_place result.group.place
json.swim format_hours result.swim.secs
json.pace_100 format_minutes result.swim.pace_100
json.t1 format_minutes result.t1_secs
json.bike format_hours result.bike_secs
json.mph format_mph result.bike_mph
json.t2 format_minutes result.t2_secs
json.run format_hours result.run_secs
json.mmile format_minutes result.run_mmile
json.result_url api_race_result_url(result.race.id, result)
if result.racer.id
	json.racer_url api_racer_url(result.racer.id)
end