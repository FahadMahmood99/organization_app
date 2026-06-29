json.id project.id
json.name project.name

json.members project.members do |member|
  json.id member.id
  json.name "#{member.first_name} #{member.last_name}"
end