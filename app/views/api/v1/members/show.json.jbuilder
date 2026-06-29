json.id @member.id
json.first_name @member.first_name
json.last_name @member.last_name
json.city @member.city
json.state @member.state
json.country @member.country

if @member.team
  json.team do
    json.id @member.team.id
    json.name @member.team.name
  end
else
  json.team nil
end