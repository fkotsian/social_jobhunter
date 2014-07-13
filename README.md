#Social job-hunting for all

Schema:
=======================================

user
--
email
password

job
--
title
company
category
url
salary_bottom
salary_top

job_application
--
job
user
status: default => "applied"

company
--
name
size
industry
has_many :jobs


#Stories

<!-- users add job-applications
  this creates a Job if it doesnt exist
jobs have fields-categories (bizdev, sales, marketing, dev, devops, etc)
jobs are then surfaced by field (jobs.where :category => /cat/) -->

we also give advice on how to jobsearch
 - large number of apps
 - resume forums
 - cover letter help (examples)
 - support
 - applications/day goals
 - "loved companies" goals
 - integration with LinkedIn (see which companies you know people at)
 
user can sort by app status, app category

user can search jobs by salary, category, or location (need fields for all of these)
searchbox above the th (or perhaps IS the th--> is a filter)

company_size_max and company_size_min in DB for angellist data

parse all data

seed db with it

figure out how to ETL into DB (a job, weekly or so, daily ideally)

style signin page, perhaps make single-page (signin via AJAX; though then we lose some of the cool functionalities; not really any reason to)
 
user can track number of jobs submitted
user can track which companies they applied to
user submits app
company gets +1 app (join table: job-application)
user gets +1 app (job-application)

can give live feed of companies
all applications are surfaced by user (/kam/ just applied to /Heroku/!)

can set goal of companies or applications/day
feature: /tracking?/ or /goal?/
when activate feature, adds db query for applications where submitted_at is on DATE

can seemost popular companies
company with most applications: query Job.where(:company => /company/)

users can get offers
can mark application status; status options include: 'applied', 'phone screened', 'interviewed', 'offered', 'accepted', 'rejected'

Companies can see which users have many offers; companies can see which users have applied to many companies; companies can be suggested to users

users can indicate interest in companies
join table :user_interest

companies can create pages
companies can upload logo, description

companies can upload jobs
jobs create a new page
jobs have title, description, salary, contact_info

users can filter offers
filter job_applications by company, salary, company size, location, and application status

job_application form has autofill
title has autofill for all job titles

job_application form allows you to add new job categories
it recognizes a new entry to the category input and creates it as a JobCategory

applying to a job tells you how many jobs you have applied to that day
<!-- creating a new job_application flashes a message containing the number of jobs you have applied to that day -->

SquareSpace Logo
SquareSpace favicon (hamsters? hound?)

infinite scroll/pagination for job_applications and jobs and companies

