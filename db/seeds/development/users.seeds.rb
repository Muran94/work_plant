User.find_or_create_by!(email: "sample@example.com") do |record|
  record.first_name = "健"
  record.last_name  = "村上"
  record.password   = "password"
end