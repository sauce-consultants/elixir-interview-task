# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     SauceTest.Repo.insert!(%SauceTest.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
#
SauceTest.Repo.delete_all(SauceTest.Companies.Employee)
SauceTest.Repo.delete_all(SauceTest.Companies.Company)

company_one =
  SauceTest.Repo.insert!(%SauceTest.Companies.Company{
    name: "Sauce One",
    address_line_1: "Address 1",
    postcode: "HU1 1UU"
  })

SauceTest.Repo.insert!(%SauceTest.Companies.Company{
  name: "Sauce Two",
  address_line_1: "Address 2",
  postcode: "HU2 2UU"
})

SauceTest.Repo.insert!(%SauceTest.Companies.Company{
  name: "Sauce Three",
  address_line_1: "Address 3",
  postcode: "HU3 3UU"
})

SauceTest.Repo.insert!(%SauceTest.Companies.Employee{
  email: "employee_one@wearesauce.io",
  first_name: "Employee",
  last_name: "One",
  started_at: ~D[2021-02-05],
  company: company_one
})
