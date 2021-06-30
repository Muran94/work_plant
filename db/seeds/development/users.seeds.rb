User.find_or_create_by!(email: "headiv94@gmail.com") do |record|
  record.password   = "password"
end