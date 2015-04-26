User.create(email: 'frank@test.com', password: 'aaaabbbb', password_confirmation: 'aaaabbbb')

User.create(email: 'guest@jobhunter.com', password: 'guest', password_confirmation: 'guest')

User.create(email: 'angela@jobhunter.com', password: 'guest', password_confirmation: 'guest')


# JobCategory.create(name: "sales", display_name: "Sales")
# JobCategory.create(name: "biz_dev", display_name: "Biz Dev")
# JobCategory.create(name: "engineering", display_name: "Engineering")
# JobCategory.create(name: "marketing", display_name: "Marketing")
# JobCategory.create(name: "pr", display_name: "PR")
# JobCategory.create(name: "product_management", display_name: "Product Management")
#

operations = JobCategory.create(
  display_name: "Operations",
  name: "operations"
)

product_management = JobCategory.create(
  display_name: "Product Management",
  name: "product_management"
)

marketing = JobCategory.create(
  display_name: "Marketing",
  name: "marketing"
)
development = JobCategory.create(
  display_name: "Development",
  name: "development"
)
sales = JobCategory.create(
  display_name: "Sales",
  name: "sales"
)
design = JobCategory.create(
  display_name: "Design",
  name: "design"
)
finance = JobCategory.create(
  display_name: "Finance",
  name: "finance"
)
human_resources = JobCategory.create(
  display_name: "Human Resources",
  name: "human_resources"
)

not_avaliable = JobCategory.create(
  display_name: "Not Avaliable",
  name: "not_avaliable"
)

unknown_co = Company.unknown_co.save!
