# Database Structure

## Preexisting unused database tables

### User

Type | Field Name
--- | ---
string | email
string | password_digest

### Garden Produce

Type | Field Name
--- | ---
string | garden_id
string | produce_id
string | available_at
integer | readiness
string | planted_at

## Currently used database tables

### Crop

Type | Field Name
--- | ---
integer | produce
integer | garden_id
string | planted_at
text | description

### Garden

Type | Field Name
--- | ---
string | name
string | address
float | lat
float | long
string | contact_name_1
string | contact_number_1
string | email_1
string | contact_name_2
string | contact_number_2
string | email_2
string | image

### Produce

Type | Field Name
--- | ---
string | name
int | during
string | image
string | type

AnnualProduce and PerennialProduce are inherited from Produce using Single Table Inheritance (STI).
[Explanation of STI](https://medium.com/@dcordz/single-table-inheritance-using-rails-5-02-6738bdd5101a)

When you create an AnnualProduce or PerennialProduce table, the type attribute contains the value of AnnualProduce or PerennialProduce, which you can use to determine the type of a produce.

***

#### Annual Produce

Type | Field Name | Value
--- | --- | ---
string | name | xxx
int | during | xxx
string | image | xxx
string | type | AnnualProduce

#### Perennial Produce

Type | Field Name | Value
--- | --- | ---
string | name | xxx
int | during | xxx
string | image | xxx
string | type | PerennialProduce

***

### Volunteer

Type | Field Name
--- | ---
string | name
int | during

