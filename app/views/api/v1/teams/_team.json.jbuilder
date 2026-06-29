json.id team.id
json.name team.name

json.members team.members do |member|
  json.id member.id
  json.name member.first_name + " " + member.last_name
  json.status member.status
end